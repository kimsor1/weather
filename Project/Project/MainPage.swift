//
//  MainPage.swift
//  Project
//
//  Created by 김소리 on 6/13/24.
//

import SwiftUI

struct MainPage: View {
    
    @State var cityName: String = ""
    @State var cityWeather: String = "" // 날씨 정보
    @State var cityTemperature: String = "" // 현재 온도
    @State var cityMaxTemp: String = "" // 최고 온도
    @State var cityMinTemp: String = "" // 최저 온도
    
    @State var weatherInfo : String = ""
    @State var weatherIcon : String = ""
    @State var nickname : String = ""
    
    var body: some View {
        NavigationView(content: {
            VStack(content: {
                Spacer()
                Text("\(nickname) 님 안녕하세요 :)")
                Spacer()
                Text("오늘의 날씨")
                    .bold()
                    .font(.title2)
                Spacer()
                Image(systemName: weatherIcon)
                    .resizable()
                    .frame(width: 150,height: 150)
                Spacer()
                Text("오늘의 날씨는 \(weatherInfo)")
                Spacer()
                Text("현재 온도 : \(cityTemperature)")
                Spacer()
                HStack(content: {
                    Spacer()
                    Text("\(cityMinTemp)")
                    Spacer()
                    Text("\(cityMaxTemp)")
                    Spacer()
                })
                Spacer()
                Divider()
                Spacer()
                
                NavigationLink("오늘 뭐입지?", destination: RecommendationView())
                    .frame(width: 150,height: 50)
                    .background(Color(.black))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
                Spacer()
            })
        })
        .onAppear{
            let queryModel = QueryModel(cityName: $cityName, cityWeather: $cityWeather, cityTemperature: $cityTemperature, cityMaxTemp: $cityMaxTemp, cityMinTemp: $cityMinTemp, weatherInfo : $weatherInfo, weatherIcon: $weatherIcon)
            let userQuery = UserVM()
            let url = "http://127.0.0.1:5000/selectuserinfo"
            Task{
                await queryModel.downloadItems()
                nickname = try await userQuery.selectUserInfo(url: url)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainPage()
}
