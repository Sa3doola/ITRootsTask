//
//  UserDTO.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

typealias UserElementResponse = [UserElement]

struct UserElement: Codable {
    
    var id: Int?
    var userId: Int?
    var title, body: String?

}
