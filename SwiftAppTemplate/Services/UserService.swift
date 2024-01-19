//
//  UserService.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 10/01/24.
//

import Foundation

class UserService {
    static func updateUser(user: User) async throws -> User {
        try await NetworkManager.shared.request(.updateUser(user: user), type: User.self)
    }
}
