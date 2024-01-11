//
//  ErrorHandler.swift
//  SwiftAppTemplate
//
//  Created by Vijay Goswami on 10/01/24.
//

import Foundation

struct CustomError: Error {
    let customMessage: String
    let originalError: Error

    var localizedDescription: String {
        return "\(customMessage): \(originalError.localizedDescription)"
    }
}

class ErrorHandler {
    static func recordError(withCustomMessage message: String, _ error: Error) {
        let customError = CustomError(customMessage: message, originalError: error)
        print("ERROR: \(String(describing: error))")
        // Record error to crashlytics
        print("Custom ERROR: \(String(describing: customError))")
//        Crashlytics.crashlytics().record(error: customError)
    }
}
