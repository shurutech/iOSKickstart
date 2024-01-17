//
//  UserPreferences.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 10/01/24.
//

import Foundation

class UserPreferences{
    
    static let shared = UserPreferences()

    private let defaults = UserDefaults.standard

    private init() {}
    
    enum Keys {
        static let userName = "userName"
        static let userEmail = "userEmail"
        static let isAuthenticated = "isAuthenticated"
        static let isPrivacyPolicyAccepted = "isPrivacyPolicyAccepted"
        static let isOnboardingCompleted = "isOnboardingCompleted"
    }
    
    func deleteAllUserDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
    }
    
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
    
    var isAuthenticated: Bool {
        set{
            defaults.setValue(newValue, forKey: Keys.isAuthenticated)
        }
        get{
            return defaults.bool(forKey: Keys.isAuthenticated)
        }
    }
    
    var isPrivacyPolicyAccepted: Bool {
        set{
            defaults.setValue(newValue, forKey: Keys.isPrivacyPolicyAccepted)
        }
        get{
            return defaults.bool(forKey: Keys.isPrivacyPolicyAccepted)
        }
    }
    
    var isOnboardingCompleted: Bool {
        set{
            defaults.setValue(newValue, forKey: Keys.isOnboardingCompleted)
        }
        get{
            return defaults.bool(forKey: Keys.isOnboardingCompleted)
        }
    }
}
