//
//  AuthenticationManager.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import Foundation

class AuthenticationManager : ObservableObject {
    static let shared = AuthenticationManager()
    private init() {}
    
    // MARK: - Attributes
    @Published var isAuthenticated = false
    
    
    // MARK: - Functions
    
    func login() {
        isAuthenticated = true
    }
    
    func logout() {
        isAuthenticated = false
    }
    
    func deleteAccount() {
        isAuthenticated = false
    }
}
