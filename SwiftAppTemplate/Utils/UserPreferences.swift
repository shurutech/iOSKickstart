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
        static let user = "user"
        static let isAuthenticated = "isAuthenticated"
        static let isProfileComplete = "isProfileComplete"
        static let isPrivacyPolicyAccepted = "isPrivacyPolicyAccepted"
        static let isOnboardingCompleted = "isOnboardingCompleted"
        static let selectedAppearance = "selectedAppearance"
    }
    
    func deleteAllUserDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
    }
    
    func saveUser(user: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            defaults.set(encoded, forKey: Keys.user)
            defaults.synchronize()
        }
    }
    
    func getUser() -> User? {
        if let savedUser = defaults.object(forKey: Keys.user) as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                return loadedUser
            }
        }
        return nil
    }
    
    var isAuthenticated: Bool {
        set{
            defaults.setValue(newValue, forKey: Keys.isAuthenticated)
        }
        get{
            return defaults.bool(forKey: Keys.isAuthenticated)
        }
    }
    
    var isProfileComplete: Bool {
        set{
            defaults.setValue(newValue, forKey: Keys.isProfileComplete)
        }
        get{
            return defaults.bool(forKey: Keys.isProfileComplete)
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
    
    var selectedAppearance: String {
        set{
            defaults.setValue(newValue, forKey: Keys.selectedAppearance)
        }
        get{
            return defaults.string(forKey: Keys.selectedAppearance) ?? AppearanceMode.light.rawValue
        }
    }
}
