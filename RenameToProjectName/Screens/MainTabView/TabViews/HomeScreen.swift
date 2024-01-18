//
//  HomeTabView.swift
//  SwiftAppTemplate
//
//  Created by Gunveer Sandhu on 03/01/24.
//

import SwiftUI

struct HomeScreen: View {
    @State var isInfoScreenPresented = false
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
                VStack(spacing: 20){
                    if(!viewModel.isDataLoading){
                        ForEach(viewModel.weatherData, id: \.self){ data in
                            CardView(title: data.name,
                                     subTitle: makeDescription(weatherItem: data))
                            .onTapGesture {
                                viewModel.selectedCardIndex = viewModel.weatherData.firstIndex(of: data)!
                                isInfoScreenPresented = true
                            }
                        }.fullScreenCover(isPresented: $isInfoScreenPresented, content: {
                            WeatherDetailScreen(weatherData: viewModel.weatherData[viewModel.selectedCardIndex])
                        })
                    }
                }
                .padding(.top)
                .padding(.horizontal, 20)
            }
            .alert(isPresented: Binding<Bool>(
                        get: { viewModel.apiError != nil },
                        set: { _ in viewModel.apiError = nil }
                    )) {
                        Alert(
                            title: Text("Error"),
                            message: Text(viewModel.apiError?.localizedDescription ?? "An unknown error occurred"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
        }
        .frame(maxWidth: .infinity)
        .loader(viewModel.isDataLoading)
        .onAppear{
            getWeatherData()
        }
    }
    
    //MARK: - Functions
    
    private func getWeatherData() {
        Task { @MainActor in
            await viewModel.getWeatherData()
        }
    }
    
    private func makeDescription(weatherItem: WeatherData) -> String{
        var description = ""
        
        description += "Summary: \(weatherItem.weather[0].description) \n"
        description += "Temp: \(kelvinToCelsius(kelvinTemp: weatherItem.main.temp)) °C \n"
        description += "Humidity: \(weatherItem.main.humidity)%"
        
        return description
    }

}

#Preview {
    HomeScreen()
}
