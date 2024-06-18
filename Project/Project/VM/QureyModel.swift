//
//  QureyModel.swift
//  Project
//
//  Created by 김소리 on 6/13/24.
//

import SwiftUI

struct QueryModel{
    
    var apiKey : String = "c3874b40519d4a8b15170a534e3817c0"
    @Binding var cityName: String
    @Binding var cityWeather: String
    @Binding var cityTemperature: String
    @Binding var cityMaxTemp: String
    @Binding var cityMinTemp: String
    @Binding var weatherInfo : String
    @Binding var weatherIcon : String
    
    func downloadItems() async{
        
        let urlPath = "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=\(apiKey)"
        let url: URL = URL(string: urlPath.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)!
        
        DispatchQueue.global().async {
            
            if let data = try? Data(contentsOf: url){
                DispatchQueue.main.async {
                    parseJSON(data)
                }
            }
            
        }
        
    }
    
    func parseJSON(_ data: Data){
        let decoder = JSONDecoder()
        var locations: [DBModel] = []
        do{
            let w = try decoder.decode(WeatherJSON.self, from: data)
            let query = DBModel(r_id: w.weather.first!.id, r_main: w.weather.first!.main, r_description: w.weather.first!.description, r_icon: w.weather.first!.icon, r_temp: w.main.temp, r_feels_like: w.main.feels_like, r_temp_min: w.main.temp_min, r_temp_max: w.main.temp_max, r_name: w.name)
            locations.append(query)
            
        }catch let error{
            print("Fail : \(error.localizedDescription)")
        }
        
        DispatchQueue.main.async {
            itemDownloaded(items: locations)
        }
        
    }
    
    func itemDownloaded(items: [DBModel]) {
        
        switch items[0].r_main{
        case "Thunderstorm":
            weatherInfo = "뇌우가 올 것으로 예상됩니다./n우산을 꼭 챙겨서 외출하세요!"
            weatherIcon = "cloud.bolt.rain"
        case "Drizzle":
            weatherInfo = "이슬비가 내릴 것으로 예상됩니다."
            weatherIcon = "cloud.drizzle"
        case "Rain" :
            weatherInfo = "비가 내릴 것으로 예상됩니다."
            weatherIcon = "cloud.heavyrain"
        case "Snow" :
            weatherInfo = "눈이 내릴 것으로 예상됩니다."
            weatherIcon = "cloud.snow"
        case "Clear" :
            weatherInfo = "맑을 것으로 예상됩니다."
            weatherIcon = "sun.max"
        default:
            weatherInfo = "맑지 않을 것으로 예상됩니다."
            weatherIcon = "smoke"
        }
        
        cityName = items[0].r_name
        cityWeather = items[0].r_main
        cityTemperature = "\(Int(items[0].r_temp - 273.15))"
        cityMaxTemp = "\(Int(items[0].r_temp_max - 273.15))"
        cityMinTemp = "\(Int(items[0].r_temp_min - 273.15))"
        
    }
    
    
} // QueryModel

