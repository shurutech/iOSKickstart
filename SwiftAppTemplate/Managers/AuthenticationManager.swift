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
    @Published var isAuthenticated = false
    
    
    // MARK: - Functions
    
    func login(user: User) async throws {
        let authToken = "dummy_token_qwertyuiopasdfghjklzxcvbnm"
        UserPreferences().userName = user.name
        UserPreferences().userEmail = user.email
        if(KeyChainStorage.shared.setAuthToken(authToken)){
            isAuthenticated = true
        }
        else {
            print("Failed to store token")
        }
    }
    
    func logout() async throws {
        isAuthenticated = false
    }
    
    func deleteAccount() {
        isAuthenticated = false
    }
}
