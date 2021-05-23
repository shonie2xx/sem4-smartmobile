//
//  QuestionViewModel.swift
//  JustAskIt
//
//  Created by Aleksandar Lekov on 20/05/2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class QuestionAddViewModel: ObservableObject {
    
//    var userID = Auth.auth().currentUser?.uid

    @Published var question: Question = Question(userId: "", date: Date(), tags: [""], bodyText: "", totalAnswerLikes: 0, answers: [])
    
    private var db = Firestore.firestore()
    
    func addQuestion(question: Question)
    {
        do
        {
//            self.question.userId = userID ?? "mamka mu"
            let _ = try db.collection("Questions2").addDocument(from: question)
        }
        catch{
            print(error)
        }
    }
    
    
    func save(bodyText: String, tagsArray: [String]){
        question.bodyText = bodyText
        question.tags = tagsArray
        question.userId = Auth.auth().currentUser!.uid
        addQuestion(question: question)
    }
}
