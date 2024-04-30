//
//  UserDetailsScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 12/04/24.
//

import SwiftUI
import Foundation

struct UserDetailsScreen: View {
    @State var name: String = ""
    @State private var selectedGender: Gender = .male
    @State private var dateOfBirth = Date()
    @State private var showingDatePicker = false
    @State var selectedCountry: String = "India"
    var selectedLanguage: String {
           guard let languageCode = Locale.current.languageCode,
                 let languageName = Locale.current.localizedString(forLanguageCode: languageCode) else {
               return "English"
           }
           return languageName
       }
    var startDate = Calendar.current.date(byAdding: .year, value: -100, to: Date()) ?? Date()
    let onCompleted: () -> Void
    
    
    var body: some View {
        VStack {
            Header(text: AppStrings.UserDetails)
            
            CustomTitleTextFieldView(label: AppStrings.Name, placeholder: AppStrings.NamePlaceHolder, inputText: $name)
                .padding(.vertical, 20)
            
            
            GenderView(selectedGender: $selectedGender)
            
            CustomTitleTextFieldView(label: AppStrings.DateOfBirth, placeholder: AppStrings.DateOfBirthPlaceHolder, inputText: Binding.constant(formatDate(dateOfBirth)))
                .onTapGesture {
                    self.showingDatePicker = true
                }
                .popover(isPresented: $showingDatePicker, attachmentAnchor: .point(.bottom), arrowEdge: .bottom) {
                    DatePickerPopover(isPresented: $showingDatePicker, dateSelection: $dateOfBirth, title: AppStrings.DateOfBirthPlaceHolder, doneButtonLabel: AppStrings.Done)
                }
                .padding(.vertical, 20)

            CountryView(selectedCountry: $selectedCountry)
            
            CustomTitleTextFieldView(label: AppStrings.SelectLanguage, placeholder: AppStrings.SelectCountryPlaceHolder, inputText: Binding.constant(selectedLanguage))
                .onTapGesture {
                    openDeviceSettings()
                }
                .padding(.vertical, 20)
     
            Spacer()
            
            TextButton(onClick: {
                if hasEnteredAllDetails() {
                    AnalyticsManager.logButtonClickEvent(buttonType: ButtonType.primary, label: "Continue")
                    
                    saveUserDetails(name: name, email: UserPreferences.shared.getUser()?.email ?? "", dob: dateOfBirth, gender: selectedGender, country: selectedCountry, language: selectedLanguage)
                    
                    onCompleted()
                }
            }, text: AppStrings.Continue)
        }
        .padding(20)
        .onAppear {
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self), screenClass: String(describing: Self.self))
        }
        Spacer()
    }
    
    func hasEnteredAllDetails() -> Bool {
        return !name.isEmpty && !selectedGender.rawValue.isEmpty && !dateOfBirth.description.isEmpty && !selectedCountry.isEmpty && !selectedCountry.isEmpty
    }
}

#Preview {
    UserDetailsScreen(onCompleted: {})
}
