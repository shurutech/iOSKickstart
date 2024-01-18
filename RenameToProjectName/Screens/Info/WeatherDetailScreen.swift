//
//  WeatherDetailScreen.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 10/01/24.
//

import SwiftUI

struct WeatherDetailScreen: View {
    var weatherData: WeatherData
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Header(text: "\(weatherData.name) Weather", hasBackButton: true, onBackArrowClick: {
                dismiss()
            })
            Spacer()
            infoText(text: "Temprature is", info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.temp).description) °C")
            infoText(text: "Real feel is", info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.feelsLike).description) °C")
            infoText(text: "Max it will go is", info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.tempMax).description) °C")
            infoText(text: "Min it will fall is", info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.tempMin).description) °C")
            infoText(text: "You can see as far as", info: "\(weatherData.visibility/1000) km")
            infoText(text: "The pressue you'd be feeling is", info: "\(weatherData.main.pressure) hectopascal")
            Spacer()
        }.padding()
    }
    
    func infoText(text: String, info: String) -> some View{
        VStack{
            Text("\(text) \(info)")
                .font(.notoSansBold16)
                .frame(maxWidth: .infinity)
            Divider()
        }
    }
}

//#Preview {
//    InfoScreen()
//}
