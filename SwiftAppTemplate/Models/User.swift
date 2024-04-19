//
//  User.swift
//  SwiftAppTemplate
//
//  Created by Ashok Choudhary on 03/01/24.
//

import Foundation

struct User: Codable{
    let name: String?
    let email: String
    let password: String
    let gender: String?
    let dob: String?
    let country: String?
    let language: String?
    
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
        self.name = nil
        self.dob = nil
        self.gender = nil
        self.country = nil
        self.language = nil
    }
    
    init(name: String, email: String, password: String, dob: String, gender: String, country: String, language: String) {
        self.email = email
        self.password = password
        self.name = name
        self.dob = dob
        self.gender = gender
        self.country = country
        self.language = language
    }
}
