//
//  ClothesVM.swift
//  Project
//
//  Created by 김소리 on 6/17/24.
//

import Foundation

struct ClothesVM{
    func insertOuter(outer : [String]) async throws{
        var nickname = usernickname()
        
        //"패딩", "겨울코트", "경량패딩", "트렌치코트", "얇은코트", "가디건", "후드집업", "얇은가디건"
        var padding : Int = 0
        var wintercoat : Int = 0
        var lightpadding : Int = 0
        var trenchcoat : Int = 0
        var thincoat : Int = 0
        var cardigan : Int = 0
        var zipup : Int = 0
        var thincardigan : Int = 0
        
        for o in outer{
            switch o{
            case "패딩":
                padding = 1
            case "겨울코트":
                wintercoat = 1
            case "경량패딩":
                lightpadding = 1
            case "트렌치코트":
                trenchcoat = 1
            case "얇은코트":
                thincoat = 1
            case "가디건":
                cardigan = 1
            case "후드집업":
                zipup = 1
            case "얇은가디건":
                thincardigan = 1
            default :
                print("")
            }
        }
        
        let url = "http://127.0.0.1:5000//insertouter?nickname=\(nickname)&padding=\(padding)&wintercoat=\(wintercoat)&lightpadding=\(lightpadding)&trenchcoat=\(trenchcoat)&thincoat=\(thincoat)&cardigan=\(cardigan)&zipup=\(zipup)&thincardigan=\(thincardigan)"
        let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
        try JSONDecoder().decode([Dictionary<String,String>].self, from: data)
    }
    
    func insertTop(top : [String]) async throws{
        var nickname = usernickname()
        
        //"민소매","반팔","얇은 긴팔","긴팔 티셔츠","후드티","맨투맨","니트"
        var sleeveless : Int = 0
        var shortsleeve : Int = 0
        var thinlongsleeve : Int = 0
        var longsleeveshirt : Int = 0
        var hoodie : Int = 0
        var sweatshirt : Int = 0
        var knit : Int = 0
        
        for t in top{
            switch t{
            case "민소매":
                sleeveless = 1
            case "반팔":
                shortsleeve = 1
            case "얇은 긴팔":
                thinlongsleeve = 1
            case "긴팔 티셔츠":
                longsleeveshirt = 1
            case "후드티":
                hoodie = 1
            case "맨투맨":
                sweatshirt = 1
            case "니트":
                knit = 1
            default :
                print("")
            }
            
            let url = "http://127.0.0.1:5000/inserttop?nickname=\(nickname)&sleeveless=\(sleeveless)&shortsleeve=\(shortsleeve)&thinlongsleeve=\(thinlongsleeve)&longsleeveshirt=\(longsleeveshirt)&hoodie=\(hoodie)&sweatshirt=\(sweatshirt)&knit=\(knit)"
            let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
            try JSONDecoder().decode([Dictionary<String,String>].self, from: data)
        }
    }
    
    func insertBottom(bottom : [String]) async throws{
        var nickname = usernickname()
        
//        "반바지", "면바지&청바지", "기모바지"
        var shorts : Int = 0
        var jeans : Int = 0
        var fleecepants : Int = 0
        
        for b in bottom{
            switch b{
            case "반바지":
                shorts = 1
            case "면바지&청바지":
                jeans = 1
            case "기모바지":
                fleecepants = 1
            default :
                print("")
            }
            
            let url = "http://127.0.0.1:5000/insertbottom?nickname=\(nickname)&shorts=\(shorts)&jeans=\(jeans)&fleecepants=\(fleecepants)"
            let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
            try JSONDecoder().decode([Dictionary<String,String>].self, from: data)
        }
    }
    
    func usernickname() -> String{
        var nickname = ""
        
        let query = UserVM()
        nickname = query.queryDB()
        
        return nickname
    }
    
}
