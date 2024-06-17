//
//  UserVM.swift
//  Project
//
//  Created by 김소리 on 6/17/24.
//

import Foundation

struct UserVM{
    
    func insertUserInfo(url:String) async throws -> String{
        let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
        let result = try JSONDecoder().decode([Dictionary<String,String>].self, from: data)
        return result[0]["result"]!
    }
    
    func selectUserInfo(url:String) async throws -> String{
        let (data, _) = try await URLSession.shared.data(from: URL(string:url)!)
        let result = try JSONDecoder().decode([[String]].self, from: data)
        return result[0][0]
        print("\(result[0][0])")
    }
}
