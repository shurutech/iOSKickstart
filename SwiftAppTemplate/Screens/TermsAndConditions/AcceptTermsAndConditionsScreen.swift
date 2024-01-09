//
//  AcceptTermsAndConditionsScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct AcceptTermsAndConditionsScreen: View {
    private let title: LocalizedStringKey = "Terms & Conditions"
    private let buttonLabel: LocalizedStringKey = "Next"
    
    let onCompleted: () -> Void
    @State var isTermsSelected: Bool = false
    
    //MARK: - Views
    
    var body: some View {
        ZStack {
            VStack {
                Header(text: title)
                
                termsView
                
                Spacer()
                
                TextButton(onClick: { onNextPressed() }, text: buttonLabel, color: canGoNext() ? .primary : .gray)
            }
        }
        .padding()
    }
    
    var termsView: some View {
        HStack(spacing: 12) {
            Button(action: {
                isTermsSelected.toggle()
            }) {
                Image(systemName: isTermsSelected ? "checkmark.square" : "square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundColor(.primary)
            }
            
            Text("Terms and Conditions")
                .font(.notoSansMedium16)
                .foregroundColor(.primary)
        }
        .padding(.top, 30)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //MARK: - Functions
    
    private func canGoNext() -> Bool {
        return isTermsSelected
    }
    
    private func onNextPressed() {
        if(!canGoNext()) {
            return
        }
        onCompleted()
    }
}

#Preview {
    AcceptTermsAndConditionsScreen(onCompleted: {})
}
