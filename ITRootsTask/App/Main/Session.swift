//
//  Session.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//



import Foundation

struct Session {

    static var isAuthorized: Bool {
        get {
            return true
        }
        set {
            UserDefaults.isLogin = newValue
        }
    }
    
    static var userData: UserDTO? {
        get {
            return UserDefaults.user
        }
        set {
            UserDefaults.user = newValue
        }
    }
    
    static var token: String {
        get {
            return UserDefaults.accessToken ?? ""
        }
        set {
            UserDefaults.accessToken = newValue
        }
    }
}
