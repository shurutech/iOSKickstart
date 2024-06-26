//
//  TermsAndConditionsScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct TermsAndConditionsScreen: View {
    let onCompleted: () -> Void
    @State var isTermsSelected: Bool = false
    @State var isLoading: Bool = true
    @State var showError: Bool = false
    
    //MARK: - Views
    
    var body: some View {
        ZStack {
            VStack {
                Header(text: AppStrings.TermsAndConditions)
                
                Text(AppStrings.DummyTermsAndConditions)
                    .padding(.top, 50)
                
                termsView
                
                Spacer()
                
                TextButton(onClick: { onNextPressed() }, text: AppStrings.Next, color: canGoNext() ? .primaryNavyBlue : .gray)
            }
        }
        .padding()
        .onAppear {
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self))
        }
    }
    
    var termsView: some View {
        Button(action: {
            isTermsSelected.toggle()
        }) {
            HStack(spacing: 12) {
                Image(systemName: isTermsSelected ? "checkmark.square" : "square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundColor(.primaryNavyBlue)
                
                Text(AppStrings.ReadAndAcceptTermsConditions)
                    .font(.notoSansMedium16)
                    .foregroundColor(.primaryNavyBlue)
            }
            
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
            AnalyticsManager.logButtonClickEvent(buttonType: ButtonType.primary, label: "Next")
            return
        }
        onCompleted()
    }
}

#Preview {
    TermsAndConditionsScreen(onCompleted: {})
}
