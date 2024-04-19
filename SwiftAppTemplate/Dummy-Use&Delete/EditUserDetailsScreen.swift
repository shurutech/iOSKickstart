//
//  EditUserDetailsScreen.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 16/04/24.
//

import SwiftUI

struct EditUserDetailsScreen: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var selectedGender: Gender = .male
    @State private var dateOfBirth = Date()
    @State private var showingDatePicker = false
    @State private var selectedCountry: String = ""
    private var selectedLanguage: String {
           guard let languageCode = Locale.current.languageCode,
                 let languageName = Locale.current.localizedString(forLanguageCode: languageCode) else {
               return "English"
           }
           return languageName
       }
    private var startDate = Calendar.current.date(byAdding: .year, value: -100, to: Date()) ?? Date()
    @Environment(\.dismiss) var dismiss
    @State private var showConfirmation: Bool = false
    @State private var isConfirmationGiven: Bool  = false
    
    var body: some View {
        ZStack {
            VStack {
                Header(text: "UpdateUserDetails", hasBackButton: true, onBackArrowClick: {
                    dismiss()
                })
                
                nameField
                    .padding(.vertical, 20)
                
                emailField
                
                genderField
                    .padding(.vertical, 20)
                
                dobField
                
                countryField
                    .padding(.vertical, 20)
                
                languageField
                
                Spacer()
                
                TextButton(onClick: {
                    if hasEnteredAllDetails() {
                        showConfirmation = true
                    }
                }, text: "Update")
            }
            .padding(20)
           
            Spacer()
            
            bottomSheet
        }
        .onChange(of: isConfirmationGiven) { isConfirmationGiven in
            if(isConfirmationGiven){
                saveDetails()
                dismiss()
            }
        }
        .onAppear(){
            initializeDetails()
        }
     
    }
    
    private var nameField : some View {
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
    
    private var emailField : some View {
        VStack(alignment: .leading) {
            Text(getLocalString("Email"))
                .font(.notoSansMedium16)
                .foregroundColor(.primaryNavyBlue)
            TextField(getLocalString("EmailPlaceHolder"), text: $email)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primaryNavyBlue,  lineWidth: 1)
                )
        }
    }
    
    private var genderField : some View {
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
    
    private var dobField: some View {
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
    
    private var countryField: some View {
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
    
    private var languageField: some View {
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
    
    private var bottomSheet: some View {
        CustomBottomSheetView(isOpen: $showConfirmation, maxHeight: 250, content: {
            ConfirmationSheet(isConfirmationGiven: $isConfirmationGiven, isOpen: $showConfirmation, title: "SaveUserInfoBottomSheetTitle", subTitle: "SaveUserInfoBottomSheetSubTitle")
        })
    }
    
    private func hasEnteredAllDetails() -> Bool {
        return !name.isEmpty && !selectedGender.rawValue.isEmpty && !dateOfBirth.description.isEmpty && !selectedCountry.isEmpty && !selectedCountry.isEmpty
    }
    
    private func initializeDetails() {
        let user = UserPreferences.shared.getUser()
        name = user?.name ?? ""
        email = user?.email ?? ""
        selectedGender = Gender(rawValue: user?.gender ?? Gender.male.rawValue) ?? Gender.male
        let dob = user?.dob ?? formatDate(Date())
        dateOfBirth =   dob.formattedDate(format: "dd-MM-yyyy") ?? Date()
        selectedCountry = user?.country ?? ""
    }
    
    private func saveDetails() {
        let user = User(name: name, email: email, password: KeyChainStorage.shared.getPassword(), dob: formatDate(dateOfBirth), gender: selectedGender.rawValue, country: selectedCountry, language: selectedLanguage)
        UserPreferences.shared.saveUser(user: user)
    }
}

#Preview {
    EditUserDetailsScreen()
}
