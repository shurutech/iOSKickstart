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
        case logout
        case delete
        
        var title: LocalizedStringKey {
            switch self {
            case .logout:
                AppStrings.LogoutBottomSheetTitle
            case .delete:
                AppStrings.DeleteAccountBottomSheetTitle
            }
        }
        
        var subTitle: LocalizedStringKey {
            switch self {
            case .logout:
                AppStrings.LogoutBottomSheetSubTitle
            case .delete:
                AppStrings.DeleteAccountBottomSheetSubTitle
            }
        }
        
        var sheetSize: CGFloat {
            switch self {
            case .logout:
                300
            case .delete:
                300
            }
        }
        
    }
    
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var gender: String = ""
    @Published var dob: String = ""
    @Published var country = ""
    @Published var language: String = {
        guard let languageCode = Locale.current.languageCode,
              let languageName = Locale.current.localizedString(forLanguageCode: languageCode) else {
            return "English"
        }
        return languageName
    }()
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
        case .logout:
            performLogout()
        case .delete:
            deleteAccount()
        case nil:
            ErrorHandler.logError(message: "No bottom sheet found", error: AppError.genericError)
        }
    }
    
    func performLogout() {
        Task { @MainActor in
            do {
                try await AuthenticationManager.shared.logout()
            }
            catch {
                ErrorHandler.logError(message: "Error while logging out.", error: error)
            }
        }
    }
    
    func deleteAccount() {
        Task { @MainActor in
            do {
                try await AuthenticationManager.shared.deleteAccount()
            }
            catch {
                ErrorHandler.logError(message: "Error while deleting account.", error: error)
            }
        }
    }
    
    
    func setUp(){
        let user = UserPreferences.shared.getUser()
        userName = user?.name ?? ""
        userEmail = user?.email ?? ""
        gender = user?.gender ?? Gender.male.rawValue
        dob = user?.dob ?? ""
        country = user?.country ?? ""
    }
}
