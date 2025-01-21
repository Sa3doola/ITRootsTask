//
//  GlobalAuthValidationProtocol.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//



import Foundation

 //MARK: - Global -

protocol GlobalAuthValidationProtocol{
    func validate(phone: String?) throws
    func validate(password: String?) throws
}

extension GlobalAuthValidationProtocol {
    
    func validate(phone: String?) throws {
        guard let phone = phone, !phone.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyPhoneNumber
        }
        guard phone.isValidPhoneNumber(pattern: RegularExpression.saudiArabiaPhone.value) else {
            throw ValidationError.incorrectPhoneNumber
        }
    }
    
    func validate(password: String?) throws {
        guard let password = password, !password.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyPassword
        }
        guard password.count > 5 else {
            throw ValidationError.shortPassword
        }
    }
}

 // MARK: - Login -

protocol LoginValidatorProtocol: GlobalAuthValidationProtocol{
   
}

 //MARK: - Register -

protocol RegisterValidatorProtocol:GlobalAuthValidationProtocol{
    func validate(fullName: String?) throws
    func validate(userName: String?) throws
    func validate(email: String?) throws
}
