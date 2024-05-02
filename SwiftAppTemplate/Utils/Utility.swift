//
//  Utility.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 10/01/24.
//

import Foundation
import UIKit

enum Gender: String, CaseIterable, Identifiable {
    case male = "Male"
    case female = "Female"
    case other = "Other"

    var id: String { self.rawValue }
}

var userLanguage: String = {
    guard let languageCode = Locale.current.languageCode,
          let languageName = Locale.current.localizedString(forLanguageCode: languageCode) else {
        return "English"
    }
    return languageName
}()

func saveUserDetails(name: String, email: String, dob: Date, gender: Gender, country: String, language: String){
    let user = User(name: name, email: email, password: KeyChainStorage.shared.getPassword(), dob: formatDate(dob), gender: gender.rawValue, country: country, language: language)
    UserPreferences.shared.saveUser(user: user)
}

func removeFocusFromTextField(){
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
}

func kelvinToCelsius(kelvinTemp: Double) -> Double {
    let celsius = kelvinTemp - 273.15
    return celsius.rounded(toPlaces: 2)
}

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MM-yyyy"
    return formatter.string(from: date)
}

func openDeviceSettings() {
       guard let url = URL(string: UIApplication.openSettingsURLString) else {
           return
       }
       UIApplication.shared.open(url)
   }

extension Double {
    func formattedAsIntegerOrDecimal() -> String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    func rounded(toPlaces places: Int) -> Double {
        let multiplier = pow(10.0, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
}

extension String {
    var nilIfEmpty: String? {
        self == "" ? nil : self
    }
    
    func formattedDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}

extension String? {
    func isNotNullOrEmpty() -> Bool{
        return !(self == nil || self!.isEmpty)
    }
}

func getLocalString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}
