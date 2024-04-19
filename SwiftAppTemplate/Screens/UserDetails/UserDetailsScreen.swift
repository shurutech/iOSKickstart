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
            Header(text: "UserDetails")
            
            nameField
                .padding(.vertical, 20)
            
            genderField
            
            dobField
                .padding(.vertical, 20)

            countryField
            
            languageField
                .padding(.vertical, 20)
     
            Spacer()
            
            TextButton(onClick: {
                if hasEnteredAllDetails() {
                    saveInfo()
                    onCompleted()
                }
            }, text: "Continue")
        }
        .padding(20)
        Spacer()
    }
    
    var nameField : some View {
        VStack(alignment: .leading) {
            Text(getLocalString("Name"))
                .font(.notoSansMedium16)
                .foregroundColor(.primaryNavyBlue)
            TextField(getLocalString("NamePlaceHolder"), text: $name)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primaryNavyBlue,  lineWidth: 1)
                )
        }
    }
    
    var genderField : some View {
        VStack(alignment: .leading){
            Text(getLocalString("Gender"))
                .font(.notoSansMedium16)
                .foregroundColor(.primaryNavyBlue)
            Picker(getLocalString("GenderPlaceHolder"), selection: $selectedGender) {
                ForEach(Gender.allCases) { gender in
                    Text(getLocalString(gender.rawValue)).tag(gender)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    var dobField: some View {
        VStack(alignment: .leading){
            
            Text(getLocalString("DateOfBirth"))
                .font(.notoSansMedium16)
                .foregroundColor(.primaryNavyBlue)
            CustomTextField(inputText: Binding.constant(formatDate(dateOfBirth)), placeholder: getLocalString("DateOfBirthPlaceHolder"), cornerRadius: 10, borderColor: .primaryNavyBlue)
                .onTapGesture {
                    self.showingDatePicker = true
                }
                .popover(isPresented: $showingDatePicker, attachmentAnchor: .point(.bottom), arrowEdge: .bottom) {
                    VStack {
                        DatePicker(
                            getLocalString("DateOfBirthPlaceHolder"),
                            selection: $dateOfBirth,
                            displayedComponents: .date
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                        .frame(maxHeight: 400)
                        
                        Button(getLocalString("Done")) {
                            self.showingDatePicker = false
                        }
                        .padding()
                    }
                    .padding()
                }
        }
    }
    
    var countryField: some View {
        VStack(alignment: .leading){
            HStack {
                Text(getLocalString("SelectCountry"))
                    .font(.notoSansMedium16)
                    .foregroundColor(.primaryNavyBlue)
                Picker(getLocalString("SelectCountryPlaceHolder"), selection: $selectedCountry){
                    ForEach(Constants.countriesOptions, id: \.self){
                        country in
                        Text(country)
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                
                Spacer()
            }
        }
    }
    
    var languageField: some View {
        VStack(alignment: .leading){
            Text(getLocalString("SelectLanguage"))
                .font(.notoSansMedium16)
                .foregroundColor(.primaryNavyBlue)
            CustomTextField(inputText: Binding.constant(selectedLanguage), placeholder: getLocalString("SelectLanguagePlaceHolder"), cornerRadius: 10, borderColor: .primaryNavyBlue)
                .onTapGesture {
                    openDeviceSettings()
                }
        }
    }
    
    func hasEnteredAllDetails() -> Bool {
        return !name.isEmpty && !selectedGender.rawValue.isEmpty && !dateOfBirth.description.isEmpty && !selectedCountry.isEmpty && !selectedCountry.isEmpty
    }
    
    func saveInfo() {
        let user = User(name: name, email: UserPreferences.shared.getUser()?.email ?? "", password: KeyChainStorage.shared.getPassword(), dob: formatDate(dateOfBirth), gender: selectedGender.rawValue, country: selectedCountry, language: selectedLanguage)
        UserPreferences.shared.saveUser(user: user)
    }
}

#Preview {
    UserDetailsScreen(onCompleted: {})
}
