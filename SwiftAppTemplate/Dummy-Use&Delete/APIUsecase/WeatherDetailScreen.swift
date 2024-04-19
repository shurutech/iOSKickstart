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
            Header(text: LocalizedStringKey(getLocalString(weatherData.name) + " " + getLocalString("Weather")), hasBackButton: true, onBackArrowClick: {
                dismiss()
            })
            Spacer()
            infoText(text: getLocalString("TemperatureIs"), info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.temp).description) °C")
            infoText(text: getLocalString("RealFeelIs"), info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.feelsLike).description) °C")
            infoText(text: getLocalString("MaxItWillGoIs"), info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.tempMax).description) °C")
            infoText(text: getLocalString("MinItWillFallIs"), info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.tempMin).description) °C")
            infoText(text: getLocalString("YouCanSeeAsFarAs"), info: "\(weatherData.visibility/1000) km")
            infoText(text: getLocalString("ThePressureYouBeFeelingIs"), info: "\(weatherData.main.pressure) hectopascal")
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

