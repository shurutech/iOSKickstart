//
//  OnboardingScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct OnboardingScreen: View {
    let images: [Image] = [
        Image(.onboarding1),
        Image(.onboarding2)
    ]
    let onCompleted: () -> Void
    let onBackPressed: () -> Void
    
    @State private var selectedTab = 0

    var buttonText: LocalizedStringKey {
        selectedTab == (images.count-1) ? AppStrings.GetStarted : AppStrings.Next
    }
    
    //MARK: - Views
    
    var body: some View {
        ZStack {
            VStack {
                Header(text: AppStrings.Onboarding
                       , hasBackButton: true
                       ,onBackArrowClick: { 
                    AnalyticsManager.logButtonClickEvent(buttonType: .back, label: "")
                    onBackPressed() }
                )
                
                pageView
                
                TextButton(onClick: onNextButtonPressed, text: buttonText)
            }
            .padding()
        }
        .onAppear {
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self), screenClass: String(describing: Self.self))
        }
    }
    
    var pageView: some View {
        TabView(selection: $selectedTab) {
            
            ForEach(0..<images.count, id: \.self) { index in
               images[index]
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                   
            }
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    //MARK: - Functions
    
   private func onNextButtonPressed() {
       AnalyticsManager.logButtonClickEvent(buttonType: ButtonType.primary, label:  selectedTab == (images.count-1) ? "Get Started" : "Next" )
        if selectedTab < (images.count-1) {
            withAnimation {
                selectedTab += 1
            }
        }
        else{
            onCompleted()
        }
    }
}

#Preview {
    OnboardingScreen(onCompleted: {}, onBackPressed: {})
}
