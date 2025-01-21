//
//  UserDTO.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


typealias UserResponse = BaseResponse<UserDTO>

struct UserDTO: Codable {
    
    var id: Int?
    var fullName, username, email, phone: String?
    var token: String?

}
