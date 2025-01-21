//
//  AuthEndPoints.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


struct AuthEndPoints {
    private init() {}
}

extension AuthEndPoints {
    
    static func loginAPIComponent(_ credentials: LoginCredentials)  -> Endpoint<UserResponse> {
        return .init(
            method: .post,
            path: "login",
            body: [
                "phone": credentials.phone,
                "user_Type": credentials.phone,
                "password": credentials.password,
                "device_type": credentials.deviceType,
            ]
        )
    }
    
    static func newAccountApiComponent(_ credentials: RegisterModel)  -> Endpoint<UserResponse> {
        return .init(
            method: .post,
            path: "register",
            body: [
                "phone": credentials.phone,
                "full_name": credentials.fullname,
                "user_name": credentials.userName,
                "email": credentials.email,
                "passwprd": credentials.password,
                "device_type": credentials.deviceType
            ]
        )
    }

}
