//
//  AnswerViewModel.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 24/05/2021.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import FirebaseAuth

class AnswerViewModel : ObservableObject {
    @Published var currentAnswer = Answer(userId : "", date: Date(), bodyText: "",  likes : 0)
    @Published var answers = [Answer]()
    
    let db = Firestore.firestore()
    
    func addAnswer(questionId : String){
        
        do
        {
            let _ = try db.collection("Questions2").document(questionId).collection("answers2").addDocument(from: currentAnswer)
        }
        catch{
            print(error)
        }
       
    
    }
    
    func fetchData(questionID : String) {
        db.collection("Questions2").document(questionID).collection("answers2")
            .addSnapshotListener { ( querySnapshot, Error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.answers = documents.map{ ( queryDocumentSnapshot) -> Answer in
                let data = queryDocumentSnapshot.data()
                
                let userId = data["userId"] as? String
                let bodyText = data["bodyText"] as? String
                let date = data["date"] as! Timestamp
                let likes = data["totalAnswerLikes"] as? Int
                
                return Answer(userId: userId!, date: date.dateValue()  , bodyText: bodyText!,  likes : likes ?? 0 )
            }
        }
    }
    
    func save(questionID : String, bodyText : String){
        currentAnswer.userId = Auth.auth().currentUser!.uid
        currentAnswer.date = Date()
        currentAnswer.bodyText = bodyText
        print("\(questionID)")
        addAnswer(questionId : questionID)
    }
}
