//
//  JSONModel.swift
//  OpenWeather
//
//  Created by Kenny Hahn on 2/25/24.
//

import Foundation

struct WeatherJSON: Codable{
    let weather : [Weather]
    let main : Main
    let name: String
    
}

// weather 객체
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// main 객체
struct Main: Codable{
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}
