//
//  AcceptTermsAndConditionsScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct AcceptTermsAndConditionsScreen: View {
    private let title: String = "Terms & Conditions"
    private let buttonText: String = "Next"
    private let tncText: String = "Read and accept Terms & Conditions"
    
    let onCompleted: () -> Void
    @State var isTermsSelected: Bool = false
    
    //MARK: - Views
    
    var body: some View {
        ZStack {
            VStack {
                Header(text: getLocalString(title))
                
                termsView
                
                Spacer()
                
                TextButton(onClick: { onNextPressed() }, text: getLocalString(buttonText), color: canGoNext() ? .primaryNavyBlue : .gray)
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
                    .foregroundColor(.primaryNavyBlue)
            }
            
            Text(getLocalString(tncText))
                .font(.notoSansMedium16)
                .foregroundColor(.primaryNavyBlue)
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
