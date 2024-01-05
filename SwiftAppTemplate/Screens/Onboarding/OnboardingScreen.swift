//
//  OnboardingScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct OnboardingScreen: View {
    private let title: LocalizedStringKey = "Onboarding"
    private let buttonLabel: LocalizedStringKey = "Done"
    let onCompleted: () -> Void
    let onBackPressed: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Header(text: title, hasBackButton: true, onBackArrowClick: { onBackPressed() })
                Spacer()
                TextButton(onClick: { onCompleted() }, text: buttonLabel)
            }
            .padding()
        }
    }
}

#Preview {
    OnboardingScreen(onCompleted: {}, onBackPressed: {})
}
