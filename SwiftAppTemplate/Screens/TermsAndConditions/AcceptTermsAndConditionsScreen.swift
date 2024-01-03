//
//  AcceptTermsAndConditionsScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct AcceptTermsAndConditionsScreen: View {
    var onCompleted: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Text("Terms & Conditions")
                
                PrimaryButton(label: "Accept", onClick: {
                   onCompleted()
                }, isEnable: true)
            }
        }
    }
}

#Preview {
    AcceptTermsAndConditionsScreen(onCompleted: {})
}
