//
//  KeyChainStorage.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 10/01/24.
//

import KeychainSwift

class KeyChainStorage {
    static let shared = KeyChainStorage()
    
    private init() {}
    
    private let keychainInstance = KeychainSwift()
    
    private let AUTH_TOKEN: String = "AUTH_TOKEN"
    
    func setAuthToken(_ value: String) -> Bool {
        return keychainInstance.set(value, forKey: AUTH_TOKEN)
    }
    
    func getAuthToken() -> String? {
        keychainInstance.get(AUTH_TOKEN)
    }
    
}
