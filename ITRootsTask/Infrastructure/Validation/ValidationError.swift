//
//  ValidationError.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import Foundation

enum ValidationError: Error {
    ///MARK: - Auth Module -
    
    //MARK: - Login -
    case emptyPhoneNumber
    case incorrectPhoneNumber
    
    //MARK: - Register -
    
    case emptyFullName
    case shortFullName
    case longFullName
    
    case emptyUserName
    case shortUserName
    case longUserName
    
    
    //MARK: - Email -
    case emptyMail
    case wrongMail
    
    //MARK: - Passwords -
    
    case emptyPassword
    case shortPassword
    
    
}
extension ValidationError: LocalizedError {
    var localizedDescription: String? {
        switch self {
            
            // MARK: - PHONE -
        case .emptyPhoneNumber:
            return "Please enter your phone number.".validationLocalized
        case .incorrectPhoneNumber:
            return "Please enter correct phone number.".validationLocalized
            
            
            // MARK: - NAME -
        case .emptyFullName:
            return "Please enter full name.".validationLocalized
        case .shortFullName:
            return "Full name is too short.".validationLocalized
        case .longFullName:
            return "Full name is too short.".validationLocalized
        case .emptyUserName:
            return "Full name is too short.".validationLocalized
        case .shortUserName:
            return "Full name is too short.".validationLocalized
        case .longUserName:
            return "Full name is too short.".validationLocalized
            
            // MARK: - Email -
            
        case .emptyMail:
            return "Please enter email field.".validationLocalized
        case .wrongMail:
            return "Please enter correct email address.".validationLocalized
            
            // MARK: - Passwords -
        case .emptyPassword:
            return "Please enter password field.".validationLocalized
        case .shortPassword:
            return "Password is too short, it should be 6 characters at least.".validationLocalized
            
        }
    }
}

extension String {
    
    var validationLocalized: String {
        return NSLocalizedString(self, tableName: "ValidationLocalized", bundle: Bundle.main, value: "", comment: "")
    }
    
}

