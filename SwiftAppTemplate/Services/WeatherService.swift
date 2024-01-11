//
//  WeatherService.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 10/01/24.
//

import Foundation

class WeatherService {
    
    func getWeather(city: String) async throws {
        try await NetworkManager.shared.request(.getWeather(city: city))
    }
}
