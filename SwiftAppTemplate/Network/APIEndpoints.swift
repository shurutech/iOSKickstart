//
//  ApiEndpoint.swift
//  SwiftAppTemplate
//
//  Created by Ashok Choudhary on 03/01/24.
//
import Alamofire

enum APIEndpoints{
    case getWeather(city: String)
    case updateUser(user: User)
    
    var method: HTTPMethod{
        switch self{
        case .getWeather:
            return .get
        case .updateUser:
            return .put
        }
    }
    
    var path: String{
        switch self{
        case .getWeather(let city):
            return "/data/2.5/weather?q=\(city)"
        case .updateUser:
            return "/users" //only for example, endpoint does not exist
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
