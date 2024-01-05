//
//  AcceptTermsAndConditionsScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct AcceptTermsAndConditionsScreen: View {
    private let title: LocalizedStringKey = "Terms & Conditions"
    private let buttonLabel: LocalizedStringKey = "Accept"
    
    let onCompleted: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Header(text: title)
                Spacer()
                TextButton(onClick: { onCompleted() }, text: buttonLabel)
            }
        }
        .padding()
    }
}

#Preview {
    AcceptTermsAndConditionsScreen(onCompleted: {})
}
