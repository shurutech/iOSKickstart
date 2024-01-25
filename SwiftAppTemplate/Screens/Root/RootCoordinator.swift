//
//  RootCoordinator.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import SwiftUI

struct RootCoordinator: View {
    enum Root{
        case splash
        case authorisation
        case acceptPolicy
        case onboarding
        case mainApp
    }
    
    @State private var root: Root = .splash
    
    @ObservedObject private var rootViewModel = RootViewModel()
    @ObservedObject private var authenticationManager = AuthenticationManager.shared
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            switch(root) {
            case .splash:
                SplashScreen()
                    .onAppear {
                        appStart()
                    }
            case .authorisation:
                AuthorizationScreen()
            case .acceptPolicy:
                AcceptTermsAndConditionsScreen(onCompleted: { rootViewModel.markTermsAndConditionsAccepted() })
            case .onboarding:
                OnboardingScreen(onCompleted: { rootViewModel.markOnboardingDone() }, onBackPressed: {
                    rootViewModel.isTermsAndConditionsAccepted = false
                })
            case .mainApp:
                MainTabCoordinator()
            }
        }
        .onChange(of: rootViewModel.isAppStartCompleted) { _ in updateRoot() }
        .onChange(of: authenticationManager.isAuthenticated) { _ in updateRoot() }
        .onChange(of: rootViewModel.isTermsAndConditionsAccepted) { _ in updateRoot() }
        .onChange(of: rootViewModel.isOnboardingCompleted) { _ in updateRoot() }
    }
    
    // MARK: - Functions

    private func appStart(){
        Task{ @MainActor in
            do{
                try await rootViewModel.start()
            }
            catch{
                print("Error while starting app \(error)")
            }
        }
    }
    
    private func updateRoot() {
        if(!rootViewModel.isAppStartCompleted) {
            root = .splash
        }
        else if(!authenticationManager.isAuthenticated) {
            root = .authorisation
            rootViewModel.setInitialScreenVisitedStatus()
        }
        else if(!rootViewModel.isTermsAndConditionsAccepted) {
            root = .acceptPolicy
        }
        else if(!rootViewModel.isOnboardingCompleted) {
            root = .onboarding
        }
        else {
            root = .mainApp
        }
    }
}

#Preview {
    RootCoordinator()
}
