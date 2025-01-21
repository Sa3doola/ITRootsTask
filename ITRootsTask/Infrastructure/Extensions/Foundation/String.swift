//
//  String.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import Foundation

extension String {
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func isValidPhoneNumber(pattern: String) -> Bool {
        return self.range(of: pattern ,options: .regularExpression) != nil
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return validates(to: emailRegex)
    }
    
    func isValidNumber() -> Bool {
        let phoneNumber = "[0-9]{11}$"
        return validates(to: phoneNumber)
    }
    
    func validates(to pattern: String) -> Bool {
        let urlPredicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return urlPredicate.evaluate(with: self)
    }
    
    func trimWhiteSpace() -> String{
        let newValue = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return newValue
    }
}
