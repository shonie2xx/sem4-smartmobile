//
//  Question.swift
//  questionCards
//
//  Created by Daniel Vaswani on 20/05/2021.
//

import Foundation

struct Question : Codable, Identifiable {
    @DocumentID var id : String? = UUID().uuidString
    var title : String
    
}
