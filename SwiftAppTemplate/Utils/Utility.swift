//
//  Utility.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 10/01/24.
//

import Foundation
import UIKit

func removeFocusFromTextField(){
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
}

extension Double {
    func formattedAsIntegerOrDecimal() -> String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
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
