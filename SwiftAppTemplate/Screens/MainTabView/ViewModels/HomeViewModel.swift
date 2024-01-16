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
    @Published var selectedCardIndex = 0    
    @Published var apiError: AppError?
    let cities = ["Delhi", "Jaipur", "Mumbai", "Chennai", "Bengaluru", "Kolkata", "Shimla"]
    
    func getWeatherData() async throws {
        weatherData.removeAll()
        for city in cities {
            do {
                let data = try await WeatherService().getWeather(city: city, appId: Constants.weatherAppId)
                weatherData.append(data)
            }
            catch {
                apiError = error as? AppError
            }
        }
    }
}
