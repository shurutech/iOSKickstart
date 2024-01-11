//
//  AppConfig.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 08/01/24.
//
import Foundation

enum AppConfig {
    
    private static let configDict: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("info.plist not found")
        }
        
        return dict
    }()
    
    static let BASE_URL: URL = {
        guard let urlString = configDict[Constants.BASE_URL] as? String else {
            fatalError("base url not found")
        }
        
        guard let url = URL(string: urlString) else {
            fatalError("invalid url")
        }
        
        return url
    }()
    
    static let EXAMPLE_KEY : String = {
        guard let key = configDict[Constants.EXAMPLE_KEY] as? String else {
            fatalError("example key not found")
        }
        
        return key
    }()
}
