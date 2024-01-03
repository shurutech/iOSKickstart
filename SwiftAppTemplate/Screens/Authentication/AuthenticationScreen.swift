//
//  AuthenticationScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct AuthenticationScreen: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Login/SignUp")
                
                PrimaryButton(label: "Login", onClick: {
                    AuthenticationManager.shared.login()
                }, isEnable: true)
            }
        }
    }
}

#Preview {
    AuthenticationScreen()
}
