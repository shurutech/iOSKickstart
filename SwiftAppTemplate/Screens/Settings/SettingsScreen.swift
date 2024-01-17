//
//  SettingsView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 08/01/24.
//

import SwiftUI

struct SettingsScreen: View {
    // MARK: - Attributes
    
    @StateObject var viewModel: SettingsViewModel = SettingsViewModel()
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Views
    
    var body: some View {
        ZStack{
            VStack(spacing: 30){
                
                Header(text: "Settings", hasBackButton: true, onBackArrowClick: {dismiss()})
                
                customTextFields
                
                buttons
                
            }.padding()
            
            if(viewModel.currentBottomSheetType != nil){
                bottomSheet
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            viewModel.onSaveChanges = {dismiss()}
            viewModel.setup()
        }
    }
    
    var customTextFields: some View{
        VStack{
            CustomTextField(inputText: $viewModel.userName, placeholder: "Enter Name", cornerRadius: 10, borderColor: .primaryNavyBlue)
            
            CustomTextField(inputText: $viewModel.userEmail, placeholder: "Enter Email", cornerRadius: 10, borderColor: .primaryNavyBlue)
        }
    }
    
    var buttons: some View{
        VStack{
            TextButton(onClick: {
                viewModel.currentBottomSheetType = .save
            }, text: "Save")
            Spacer()
            TextButton(onClick: {
                viewModel.currentBottomSheetType = .logout
            }, text: "Logout", style: .outline)
            TextButton(onClick: {
                viewModel.currentBottomSheetType = .delete
            }, text: "Delete Account", style: .outline)
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

#Preview {
    SettingsScreen()
}
