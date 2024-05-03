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
            Color.primaryNavyBlue.ignoresSafeArea(.all)
            VStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
            .padding()
        }
        .onAppear {
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self))
        }
    }
}

#Preview {
    SplashScreen()
}
