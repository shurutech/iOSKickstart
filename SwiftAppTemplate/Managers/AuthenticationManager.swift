//
//  AuthenticationManager.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import Foundation

@MainActor
class AuthenticationManager : ObservableObject {
    static let shared = AuthenticationManager()
    private init() {}
    
    // MARK: - Attributes
    @Published var isAuthenticated = UserPreferences.shared.isAuthenticated
    
    
    // MARK: - Functions
    
    func login(user: User) async throws {
        let authToken = "dummy_token_qwertyuiopasdfghjklzxcvbnm"
      
        if(KeyChainStorage.shared.setAuthToken(authToken)){
            UserPreferences.shared.saveUser(user: User(email: user.email, password: user.password))
            KeyChainStorage.shared.setPassword(user.password)
            UserPreferences.shared.isAuthenticated = true
            isAuthenticated = true
        }
        else {
            print("Failed to store token")
        }
    }
    
    func logout() async throws {
        UserPreferences.shared.isAuthenticated = false
        isAuthenticated = false
    }
    
    func deleteAccount() async throws {
        isAuthenticated = false
        UserPreferences.shared.deleteAllUserDefaults()
        KeyChainStorage.shared.deleteAllKey()
    }
}
