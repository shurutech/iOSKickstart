//
//  HomeViewModel.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 11/01/24.
//

import Foundation

@MainActor
class HomeViewModel : ObservableObject {
    @Published var weatherData: [WeatherData] = []
    @Published var isDataLoading = false
    private let weatherAppId = "1d8b7e6f3849be9a808176f247698ec3"
    
    let cities = ["Delhi", "Jaipur", "Mumbai", "Chennai", "Bengaluru", "Kolkata"]
    
    func getWeatherData() async throws {
        weatherData.removeAll()
        for city in cities {
            let data = try await WeatherService().getWeather(city: city, appId: weatherAppId)
            weatherData.append(data)
        }
    }
}
