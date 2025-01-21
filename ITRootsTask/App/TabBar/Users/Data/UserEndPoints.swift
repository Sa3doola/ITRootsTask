//
//  AuthEndPoints.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


struct UserEndPoints {
    private init() {}
}

extension UserEndPoints {
    
    static func usersAPI()  -> Endpoint<UserElementResponse> {
        return .init(server: "https://jsonplaceholder.typicode.com",
                     method: .get,
                     path: "/posts")
    }
}
