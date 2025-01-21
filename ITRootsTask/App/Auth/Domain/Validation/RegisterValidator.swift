//
//  RegisterValidator.swift
//  Mesllah
//
//  Created by Diab on 27/10/2024.
//

import Foundation

struct RegisterValidator: RegisterValidatorProtocol {
 
    func validate(fullName: String?) throws {
        guard let fullName = fullName, !fullName.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyFullName
        }
        guard fullName.count > 2 else {
            throw ValidationError.shortFullName
        }
        guard fullName.count < 61 else {
            throw ValidationError.longFullName
        }
    }
    
    func validate(userName: String?) throws  {
        guard let nickname = userName, !nickname.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyUserName
        }
        guard nickname.count > 2 else {
            throw ValidationError.shortUserName
        }
        guard nickname.count < 61 else {
            throw ValidationError.longUserName
        }
    }
    
    func validate(email: String?) throws  {
        guard let email = email, !email.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyMail
        }
        guard email.isValidEmail() else{
            throw ValidationError.wrongMail
        }
    }

}
