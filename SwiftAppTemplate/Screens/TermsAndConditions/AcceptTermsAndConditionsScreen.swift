//
//  AcceptTermsAndConditionsScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct AcceptTermsAndConditionsScreen: View {
    let onCompleted: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Header(text: "Terms & Conditions")
                Spacer()
                TextButton(onClick: { onCompleted() }, text: "Accept")
            }
        }
        .padding()
    }
}

#Preview {
    AcceptTermsAndConditionsScreen(onCompleted: {})
}
