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
            Header(text: LocalizedStringKey(getLocalString(weatherData.name) + " " + getLocalString(AppStrings.Weather)), hasBackButton: true, onBackArrowClick: {
                dismiss()
            })
            Spacer()
            infoText(text: AppStrings.TemperatureIs, info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.temp).description) °C")
            infoText(text: AppStrings.RealFeelIs, info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.feelsLike).description) °C")
            infoText(text: AppStrings.MaxItWillGoIs, info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.tempMax).description) °C")
            infoText(text: AppStrings.MinItWillFallIs, info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.tempMin).description) °C")
            infoText(text: AppStrings.YouCanSeeAsFarAs, info: "\(weatherData.visibility/1000) km")
            infoText(text: AppStrings.ThePressureYouBeFeelingIs, info: "\(weatherData.main.pressure) hectopascal")
            Spacer()
        }
        .padding()
        .onAppear {
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self))
        }
    }
    
    func infoText(text: LocalizedStringKey, info: String) -> some View{
        VStack{
            (Text(text) + Text(" \(info)"))
                .font(.notoSansBold16)
                .frame(maxWidth: .infinity)
            Divider()
        }
    }
}

