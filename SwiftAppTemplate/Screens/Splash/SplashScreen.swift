//
//  SplashScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 04/01/24.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea(.all)
            VStack {
                Image(.logo)
            }
            .padding()
        }
    }
}

#Preview {
    SplashScreen()
}
