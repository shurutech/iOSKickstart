//
//  SettingsViewModel.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 16/01/24.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject{
    
    enum BottomSheet{
        case save
        case logout
        case delete
        
        var title: String {
            switch self {
            case .save:
                "Do you want to save?"
            case .logout:
                "Are you sure that you want to logout?"
            case .delete:
                "This will delete all your user data. Are you sure?"
            }
        }
        
        var subTitle: String {
            switch self {
            case .save:
                "Saving this will change your username and password."
            case .logout:
                "This will log you out, and you'll have to input your credentials again to use the app."
            case .delete:
                "This is an irreversible choice. The deleted user data will not get recovered once deleted. Proceed with caution."
            }
        }
        
        var sheetSize: CGFloat {
            switch self {
            case .save:
                250
            case .logout:
                300
            case .delete:
                300
            }
        }
        
    }
    
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var isConfirmationGiven = false{
        didSet{
            if(isConfirmationGiven){
                handleConfirmation()
                currentBottomSheetType = nil
            }
        }
    }
    @Published var currentBottomSheetType: BottomSheet?
    
    
    func handleConfirmation() {
        switch currentBottomSheetType {
        case .save:
            saveUserInfo()
        case .logout:
            performLogout()
        case .delete:
            deleteAccount()
        case nil:
            print("nil")
        }
    }
    
    func saveUserInfo() {
        UserPreferences().userName = userName
        UserPreferences().userEmail = userEmail
    }
    
    func performLogout() {
        Task { @MainActor in
            do {
                try await AuthenticationManager.shared.logout()
            }
            catch {
                ErrorHandler.recordError(withCustomMessage: "Error logging out.", error)
            }
        }
    }
    
    func deleteAccount() {
        Task { @MainActor in
            do {
                try await AuthenticationManager.shared.deleteAccount()
            }
            catch {
                ErrorHandler.recordError(withCustomMessage: "Error deleting account.", error)
            }
        }
    }
    
    
    func setup(){
        userName = UserPreferences().userName
        userEmail = UserPreferences().userEmail
    }
}
