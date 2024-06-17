//
//  QueryModel.swift
//  OpenWeather
//
//  Created by Kenny Hahn on 2/25/24.
//

import SwiftUI

struct QueryModel{
    
    var apiKey : String = "423924076041216c8e695539610e467a"
    @Binding var cityName: String
    @Binding var cityWeather: String
    @Binding var cityTemperature: String
    @Binding var cityMaxTemp: String
    @Binding var cityMinTemp: String

    
    func downloadItems(cityName: String) async{
        
        let urlPath = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)"
        let url: URL = URL(string: urlPath.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)!
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url){
                DispatchQueue.main.async {
                    parseJSON(data)
                }
            }else{
                DispatchQueue.main.async {
                    errorJSON()
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

    func errorJSON(){
        var locations: [DBModel] = []
        let query = DBModel(r_id: 999, r_main: "None", r_description: "None", r_icon: "None", r_temp: 273, r_feels_like: 273, r_temp_min: 273, r_temp_max: 273, r_name: "None")
        locations.append(query)

        DispatchQueue.main.async {
            itemDownloaded(items: locations)
        }

    }
    
    func itemDownloaded(items: [DBModel]) {
        
        print(items[0].r_name)
        print(items[0].r_main)
        print("\(Int(items[0].r_temp - 273.15))°C")
        print("최고온도 : \(Int(items[0].r_temp_max - 273.15))℃")
        print("최저온도 : \(Int(items[0].r_temp_min - 273.15))℃")
        
        cityName = items[0].r_name
        cityWeather = items[0].r_main
        cityTemperature = "\(Int(items[0].r_temp - 273.15))°C"
        cityMaxTemp = "최고온도 : \(Int(items[0].r_temp_max - 273.15))℃"
        cityMinTemp = "최저온도 : \(Int(items[0].r_temp_min - 273.15))℃"

    }


} // QueryModel

