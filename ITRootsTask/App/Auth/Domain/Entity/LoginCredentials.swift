//
//  LoginCredentials.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


struct LoginCredentials {
    
    var phone: String?
    var password: String?
    
    var deviceType: String = "ios"
    
    var language: String{
        return Language.currentLanguage()
    }
}
