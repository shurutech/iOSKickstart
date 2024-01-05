//
//  AuthenticationScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct AuthorizationScreen: View {
    private let title: LocalizedStringKey = "Login/SignUp"
    private let buttonLabel: LocalizedStringKey = "Login"
    
    //MARK: - Views
    
    var body: some View {
        ZStack {
            VStack {
                Header(text: title)
                Spacer()
                TextButton(onClick: onLoginButtonClick, text: buttonLabel)
            }
            .padding()
        }
    }
    
    //MARK: - Functions
    
    private func onLoginButtonClick() {
        AuthenticationManager.shared.login()
    }
}

#Preview {
    AuthorizationScreen()
}

