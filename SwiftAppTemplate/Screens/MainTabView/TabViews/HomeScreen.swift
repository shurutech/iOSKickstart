//
//  HomeTabView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 03/01/24.
//

import SwiftUI

struct HomeScreen: View {
    @State var isInfoScreenPresented = false
    @State var selectedNum = 0
    
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(showsIndicators: false){
                    VStack(spacing: 20){
                        
                        if (viewModel.weatherData.count == viewModel.cities.count) {
                            ForEach(Array(zip(viewModel.cities.indices, viewModel.cities)), id: \.1) { index, city in
                                CardView(
                                    title: city,
                                    subTitle: viewModel.weatherData[index].weather.first?.description ?? "No Data",
                                    infoAction: {
                                        isInfoScreenPresented = true
                                    }
                                )
                                .padding(5)
                            }
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal, 20)
                NavigationLink(destination: InfoScreen(cardNum: selectedNum), isActive: $isInfoScreenPresented){}
            }
        }
        .loader(viewModel.isDataLoading)
        .onAppear{
            getWeatherData()
        }
    }
    
    //MARK: - Functions
    
    private func getWeatherData() {
        viewModel.isDataLoading = true
        Task { @MainActor in
            do {
                try await viewModel.getWeatherData()
                viewModel.isDataLoading = false
            }
            catch {
                viewModel.isDataLoading = false
                print("ERRROrrrr \(error)")
            }
        }
    }
}

#Preview {
    HomeScreen()
}
