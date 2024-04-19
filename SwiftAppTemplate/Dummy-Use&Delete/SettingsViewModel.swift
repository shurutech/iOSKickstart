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
                "LogoutBottomSheetTitle"
            case .delete:
                "DeleteAccountBottomSheetTitle"
            }
        }
        
        var subTitle: LocalizedStringKey {
            switch self {
            case .logout:
                "LogoutBottomSheetSubTitle"
            case .delete:
                "DeleteAccountBottomSheetSubTitle"
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
            print("nil")
        }
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
    
    
    func setUp(){
        let user = UserPreferences.shared.getUser()
        userName = user?.name ?? ""
        userEmail = user?.email ?? ""
        gender = user?.gender ?? Gender.male.rawValue
        dob = user?.dob ?? ""
        country = user?.country ?? ""
    }
}
