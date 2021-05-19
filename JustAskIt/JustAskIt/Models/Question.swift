//
//  Question.swift
//  JustAskIt
//
//  Created by Aleksandar Lekov on 20/05/2021.
//

import Foundation

public struct Question : Codable {
    let userId: String
    let body:String
    
    enum CodingKeys: String, CodingKey{
        case userId
        case body
    }
    
    var dictionary: [String: Any] {
            let data = (try? JSONEncoder().encode(self)) ?? Data()
            return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
        }
}

