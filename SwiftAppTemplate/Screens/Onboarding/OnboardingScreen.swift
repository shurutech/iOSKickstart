//
//  OnboardingScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct OnboardingScreen: View {
    let onCompleted: () -> Void
    let onBackPressed: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Header(text: "Onboarding", hasBackButton: true, onBackArrowClick: { onBackPressed() })
                Spacer()
                TextButton(onClick: { onCompleted() }, text: "Done")
            }
            .padding()
        }
    }
}

#Preview {
    OnboardingScreen(onCompleted: {}, onBackPressed: {})
}
