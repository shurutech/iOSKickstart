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
                
                Header(text: "Settings", hasBackButton: true, onBackArrowClick: {dismiss()})
         
                TitleValueView(title: "Name", value: viewModel.userName)
                
                TitleValueView(title: "Email", value: viewModel.userEmail)
                
                TitleValueView(title: "Gender", value: getLocalString(viewModel.gender))
                
                TitleValueView(title: "DateOfBirth", value: viewModel.dob)
        
                TitleValueView(title: "Country", value: viewModel.country)

                TitleValueView(title: "Language", value: viewModel.language)

                
                TextButton(onClick: {
                    presentEditInfoScreen = true
                }, text: "Update")
                .fullScreenCover(isPresented: $presentEditInfoScreen, onDismiss: {
                    viewModel.setUp()
                }, content: {
                    EditUserDetailsScreen()
                })
                
                AppearanceSelectionView(selectedMode: $selectedMode)
                
                buttons
                
            }.padding()
            
            if(viewModel.currentBottomSheetType != nil){
                bottomSheet
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            viewModel.setUp()
        }
    }
    
    
    var buttons: some View{
        VStack{
          
            Spacer()
            HStack{
                TextButton(onClick: {
                    viewModel.currentBottomSheetType = .logout
                }, text: "Logout", style: .outline, color: .orange)
                TextButton(onClick: {
                    viewModel.currentBottomSheetType = .delete
                }, text: "DeleteAccount", style: .outline, color: .red)
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
            Text(getLocalString("Appearance"))
            Spacer()
            Picker(getLocalString("Appearance"), selection: $selectedMode) {
                Text(getLocalString("Light")).tag(AppearanceMode.light)
                Text(getLocalString("Dark")).tag(AppearanceMode.dark)
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




