//
//  ContentView.swift
//  OpenWeather
//
//  Created by Kenny Hahn on 2/25/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var cityName: String = ""
    @State var cityWeather: String = ""
    @State var cityTemperature: String = ""
    @State var cityMaxTemp: String = ""
    @State var cityMinTemp: String = ""
    
    @FocusState var isTextFieldFocused: Bool
    
    var body: some View {
        VStack {
            
            Text("OpenWeather")
                .bold()
                .font(.title)
                .padding()
            
            TextField("City Name", text: $cityName)
                .textFieldStyle(.roundedBorder)
                .frame(width: 200)
                .multilineTextAlignment(.leading)
                .keyboardType(.default)
                .focused($isTextFieldFocused)
                .padding()

            Button ("Get Weather", action: {
                let queryModel = QueryModel(cityName: $cityName, cityWeather: $cityWeather, cityTemperature: $cityTemperature, cityMaxTemp: $cityMaxTemp, cityMinTemp: $cityMinTemp)

                Task{
                    await queryModel.downloadItems(cityName: cityName)
                }
            })
            .padding()
            .frame(width: 150)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.buttonBorder)

            Text(cityName)
                .padding()
            
            Text(cityWeather)
                .padding()
            
            Text(cityTemperature)
                .bold()
                .font(.title)
                .padding()
            
            Text(cityMaxTemp)
                .padding()
            
            Text(cityMinTemp)
                .padding()
            
            
        }
        .padding()
        
    } // View
    
} // ContentView

#Preview {
    ContentView()
}
