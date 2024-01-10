//
//  UserPreferences.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 10/01/24.
//

import Foundation

enum Keys{
    static let userName = "userName"
    static let userEmail = "userEmail"
}

class UserPreferences{
    
    var defaults = UserDefaults.standard
    
    var userName: String {
        set{
            defaults.setValue(newValue, forKey: Keys.userName)
        }
        get{
            guard let userName = defaults.value(forKey: Keys.userName) as? String else {
                return ""
            }
            return userName
        }
    }
    
    var userEmail: String {
        set{
            defaults.setValue(newValue, forKey: Keys.userEmail)
        }
        get{
            guard let userEmail = defaults.value(forKey: Keys.userEmail) as? String else {
                return ""
            }
            return userEmail
        }
    }
    
}
