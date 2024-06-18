//
//  RecommendationView.swift
//  Project
//
//  Created by 김소리 on 6/17/24.
//

import SwiftUI

struct RecommendationView: View {
    @Binding var cityTemperature: String
    @Binding var weatherInfo: String
    @Binding var cityweather : String
    
    @State var outer : [String] = []
    @State var top : [String] = []
    @State var bottom : [String] = []
    
    @State var imagename : String = ""
    
    var body: some View {
        ZStack(content: {
            Image(imagename)
                .resizable()
                .frame(height: 1500)
            
            VStack(content: {
                Text("현재 기온은 \(cityTemperature) 입니다.")
                    .padding(.bottom,30)
                    .bold()
                Text("오늘의 날씨는 \(weatherInfo)")
                    .padding(.bottom,30)
                    .bold()
                
                Text("🔻 추천 의류 🔻")
                    .padding(.bottom,30)
                    .bold()
                VStack(content: {
                    Text("겉옷 : \(concatenateItems(outer))")
                        .padding(.bottom,10)
                        .bold()
                    Text("상의 : \(concatenateItems(top))")
                        .padding(.bottom,10)
                        .bold()
                    Text("하의 : \(concatenateItems(bottom))")
                        .padding(.bottom,10)
                        .bold()
                })
            })
            
            
        })
        .onAppear{
            imageChange(weather: cityweather)
            clothes()
        }
        
    }
    
    func concatenateItems(_ items: [String]) -> String {
        if items.isEmpty {
            return ""
        } else if items.count == 1 {
            return items[0]
        } else {
            return items.joined(separator: ", ")
        }
    }
    
    func imageChange(weather : String){
        switch weather {
        case "Thunderstorm":
          imagename = "rain"
        case "Drizzle":
            imagename = "rain"
        case "Rain" :
            imagename = "rain"
        case "Snow" :
            imagename = "snow"
        case "Clear" :
            imagename = "clear"
        default:
            imagename = "smoke"
        }
    }
    
    func clothes(){
        let temp = Int(cityTemperature)
        
        //"패딩", "겨울코트", "경량패딩", "트렌치코트", "얇은코트", "가디건", "후드집업", "얇은가디건"]
        //"민소매","반팔","얇은 긴팔","긴팔 티셔츠","후드티","맨투맨","니트"
        //"반바지", "면바지&청바지", "기모바지"
        
        switch temp!{
        case 27...40 :
            outer.append("얇은가디건")
            top.append("민소매")
            top.append("반팔")
            bottom.append("반바지")
        case 23...26:
            outer.append("얇은가디건")
            top.append("얇은긴팔")
            top.append("반팔")
            bottom.append("면바지&청바지")
            bottom.append("반바지")
        case 20...22:
            outer.append("얇은가디건")
            top.append("긴팔 티셔츠")
            bottom.append("면바지&청바지")
        case 17...19:
            outer.append("가디건")
            top.append("후드티")
            top.append("맨투맨")
            bottom.append("면바지&청바지")
        case 12...16:
            outer.append("가디건")
            outer.append("얇은코트")
            top.append("긴팔티셔츠")
            bottom.append("면바지&청바지")
        case 10...11:
            outer.append("트렌치코트")
            outer.append("얇은코트")
            top.append("긴팔 티셔츠")
            bottom.append("면바지&청바지")
        case 6...9:
            outer.append("경량패딩")
            outer.append("겨울코트")
            top.append("니트")
            bottom.append("면바지&청바지")
        default :
            outer.append("패딩")
            outer.append("겨울코트")
            top.append("니트")
            bottom.append("기모바지")
        }
    }
}

#Preview {
    RecommendationView(cityTemperature: MainPage().$cityTemperature, weatherInfo: MainPage().$weatherInfo, cityweather: MainPage().$cityWeather)
}
