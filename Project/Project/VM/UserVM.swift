//
//  UserVM.swift
//  Project
//
//  Created by 김소리 on 6/17/24.
//

import Foundation
import SQLite3

//struct UserVM{
//    
//    func insertUserInfo(url:String) async throws -> String{
//        let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
//        let result = try JSONDecoder().decode([Dictionary<String,String>].self, from: data)
//        return result[0]["result"]!
//    }
//    
//    func selectUserInfo(url:String) async throws -> String{
//        let (data, _) = try await URLSession.shared.data(from: URL(string:url)!)
//        let result = try JSONDecoder().decode([[String]].self, from: data)
//        return result[0][0]
//        print("\(result[0][0])")
//    }
//}

class UserVM : ObservableObject{
    var db: OpaquePointer?
    
    // 팀 정보를 저장하는 배열입니다.
    var userinfo: [UserModel] = []
    
    init() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("project.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
        // Table 만들기
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY AUTOINCREMENT, nickname TEXT)", nil, nil, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errMsg)")
        }
        
        print(fileURL)
    }
    
    func queryDB() -> String{
        
        var nickname : String = ""
        
        var stmt: OpaquePointer?
        let queryString = "SELECT * FROM user"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errMsg)")
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            nickname = String(cString: sqlite3_column_text(stmt, 1))
        }
        
        return nickname
    }
    
    func insertDB(nickname: String) -> Bool{
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        let queryString = "INSERT INTO user (nickname) VALUES (?)"
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
                let errMsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing insert statement: \(errMsg)")
                return false
            }
        
        sqlite3_bind_text(stmt, 1, nickname, -1, SQLITE_TRANSIENT)
        
        if sqlite3_step(stmt) == SQLITE_DONE{
            return true
        }else{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
                    print("error inserting team: \(errMsg)")
            return false
        }
    }
}
