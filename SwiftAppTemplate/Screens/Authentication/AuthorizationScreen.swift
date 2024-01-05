//
//  AuthenticationScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct AuthorizationScreen: View {
    
    var body: some View {
        ZStack {
            VStack {
                Header(text: "Login/SignUp")
                Spacer()
                TextButton(onClick: { AuthenticationManager.shared.login() }, text: "Login")
            }
            .padding()
        }
    }
}

#Preview {
    AuthorizationScreen()
}

