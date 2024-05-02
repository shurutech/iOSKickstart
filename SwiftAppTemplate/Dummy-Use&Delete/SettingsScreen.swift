//
//  SettingsView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 08/01/24.
//

import SwiftUI

struct SettingsScreen: View {

    // MARK: - Attributes
    @State var presentEditInfoScreen = false
    @StateObject var viewModel: SettingsViewModel = SettingsViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var selectedMode = Preferences.appearanceMode

    
    // MARK: - Views
    
    var body: some View {
        ZStack{
            VStack(spacing: 30){
                
                Header(text: AppStrings.Settings, hasBackButton: true, onBackArrowClick: {dismiss()})
         
               userDetailsView
                
               updateButtonView
                
                AppearanceSelectionView(selectedMode: $selectedMode)
                    .padding(.top, 20)
                
                bottomButtons
                
            }.padding()
            
            if(viewModel.currentBottomSheetType != nil){
                bottomSheet
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            viewModel.setUp()
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self), screenClass: String(describing: Self.self))
        }
    }
    
    var userDetailsView: some View {
        VStack(spacing: 20) {
            TitleValueView(title: AppStrings.Name, value: viewModel.userName)
            
            TitleValueView(title: AppStrings.Email, value: viewModel.userEmail)
            
            TitleValueView(title: AppStrings.Gender, value: getLocalString(viewModel.gender))
            
            TitleValueView(title: AppStrings.DateOfBirth, value: viewModel.dob)
            
            TitleValueView(title: AppStrings.Country, value: getLocalString(viewModel.country))
            
            TitleValueView(title: AppStrings.Language, value: userLanguage)
        }
    }
    
    var updateButtonView: some View {
        TextButton(onClick: {
            AnalyticsManager.logButtonClickEvent(buttonType: .primary, label: "Update")
            presentEditInfoScreen = true
        }, text: AppStrings.Update)
        .fullScreenCover(isPresented: $presentEditInfoScreen, onDismiss: {
            viewModel.setUp()
        }, content: {
            EditUserDetailsScreen()
        })
    }
    
    var bottomButtons: some View{
        VStack{
            Spacer()
            HStack{
                TextButton(onClick: {
                    AnalyticsManager.logButtonClickEvent(buttonType: .secondary, label: "Logout")
                    viewModel.currentBottomSheetType = .logout
                }, text: AppStrings.Logout, style: .outline, color: .orange)
                TextButton(onClick: {
                    AnalyticsManager.logButtonClickEvent(buttonType: .secondary, label: "Delete Account")
                    viewModel.currentBottomSheetType = .delete
                }, text: AppStrings.DeleteAccount, style: .outline, color: .red)
            }
        }
    }
    
    var bottomSheet: some View{
        
        @State var isOpen = Binding<Bool>(
            get: { viewModel.currentBottomSheetType != nil },
            set: { if !$0 { viewModel.currentBottomSheetType = nil } }
        )
        
       return CustomBottomSheetView(isOpen: isOpen, maxHeight: viewModel.currentBottomSheetType!.sheetSize, content: {
            if viewModel.currentBottomSheetType != nil {
                ConfirmationSheet(isConfirmationGiven: $viewModel.isConfirmationGiven, isOpen: isOpen, title: viewModel.currentBottomSheetType!.title, subTitle: viewModel.currentBottomSheetType!.subTitle)
            }
        })
    }
}

struct TitleValueView: View {
    let title: LocalizedStringKey
    let value: String
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
        }
        .foregroundColor(.text)
    }
}

struct AppearanceSelectionView: View {
    @Binding var selectedMode: AppearanceMode
    
    var body: some View {
        HStack {
            Text(AppStrings.Appearance)
            Spacer()
            Picker(AppStrings.Appearance, selection: $selectedMode) {
                Text(AppStrings.Light).tag(AppearanceMode.light)
                Text(AppStrings.Dark).tag(AppearanceMode.dark)
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedMode) { newValue in
                Preferences.appearanceMode = newValue
            }
        }
        .foregroundColor(.text)
    }
}


#Preview {
    SettingsScreen()
}




