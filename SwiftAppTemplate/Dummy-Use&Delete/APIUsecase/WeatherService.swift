//
//  WeatherService.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 10/01/24.
//

import Foundation

class WeatherService {
    
    func getWeather(city: String, appId: String) async throws -> WeatherData {
        try await NetworkManager.shared.request(.getWeather(city: city, appId: appId), type: WeatherData.self)
    }
}
