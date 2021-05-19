//
//  QuestionService.swift
//  JustAskIt
//
//  Created by Aleksandar Lekov on 20/05/2021.
//

import Foundation
import Firebase
import FirebaseFirestore

class QuestionService{
    
    private init() {}
    static let shared = QuestionService()
    
    
    
    func configure(){
        FirebaseApp.configure()
        
    }
    
    let db = Firestore.firestore()
    
    func create(){
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let body = "blyblya"
        let question = Question(userId: userID,body: body)
        
//        let questionReference = Firestore.firestore().collection("questions")
        
//        questionReference.addDocument(data: question)
        
        do {
            try
                db.collection("questions").document("LA").setData(question.dictionary)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    
    func read(){
        
    }
    
    func update(){
        
    }
    
    func delete(){
        
    }
}
