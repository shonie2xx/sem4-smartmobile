//
//  User.swift
//  JustAskBizz
//
//  Created by Aleksandar Lekov on 22/05/2021.
//

import Foundation

struct User : Codable {
    var userId: String
    var email: String
    var name: String
    var followers: Int
    var likes: Int
    var title: String
 
    enum CodingKeys: String, CodingKey{
        case userId
        case email
        case name
        case followers
        case likes
        case title
    }
}
