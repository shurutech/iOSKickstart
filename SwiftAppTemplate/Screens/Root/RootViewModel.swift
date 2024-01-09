//
//  RootViewModel.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 03/01/24.
//

import Foundation

@MainActor
class RootViewModel : ObservableObject {
    
    // MARK: - Attributs
    
    @Published var isAppStartCompleted: Bool = false
    @Published var isTermsAndConditionsAccepted: Bool = false
    @Published var isOnboardingCompleted: Bool = false
    
    // MARK: - Functions
    
    func start() async throws {
        guard !isAppStartCompleted else { return }
        
        // All starting set up will be done here
        // testing load time 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(2 * 1000))) {
            self.isAppStartCompleted = true
        }
       
    }
    
    func markTermsAndConditionsAccepted() {
        guard !isTermsAndConditionsAccepted else { return }
        
        isTermsAndConditionsAccepted = true
    }
    
    func markOnboardingDone() {
        guard !isOnboardingCompleted else { return }
        
        isOnboardingCompleted = true
    }
}
