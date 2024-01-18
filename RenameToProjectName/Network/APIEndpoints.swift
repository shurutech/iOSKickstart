//
//  ApiEndpoint.swift
//  SwiftAppTemplate
//
//  Created by Ashok Choudhary on 03/01/24.
//
import Alamofire

enum APIEndpoints {
    case getWeather(city: String, appId: String)
    case updateUser(user: User)
    
    var data: (HTTPMethod, String) {
        switch self {
        case .getWeather: return (.get, "/data/2.5/weather")
        case .updateUser: return (.put, "/api/v1/users")
        }
    }

    // MARK: - Parameters

    var urlParameters: [String:String?] {
        switch self {
        case .getWeather(let city, let appId):
            return ["q": city, "appid": appId]
        default:
            return [:]
        }
    }
            
    var parameters: Encodable? {
        switch self{
        case .updateUser(let user):
            return user
        default:
            return nil
        }
    }
}
