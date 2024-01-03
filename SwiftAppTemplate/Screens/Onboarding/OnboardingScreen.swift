//
//  OnboardingScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct OnboardingScreen: View {
    var onCompleted: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Text("Onboarding")
                
                PrimaryButton(label: "Done", onClick: {
                   onCompleted()
                }, isEnable: true)
            }
        }
    }
}

#Preview {
    OnboardingScreen(onCompleted: {})
}
