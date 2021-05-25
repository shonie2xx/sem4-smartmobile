//
//  ProfileViewModel.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 22/05/2021.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    
    @Published var profile: User = User(email:"", name:"", followers:0, likes:0, title:"",about: "",industry: "", profileImageUrl: "")
    let database = Firestore.firestore()
    
    func fetchData(userId: String) {
        guard (Auth.auth().currentUser?.uid) != nil else {
            print("User not found")
            return
        }
        
        let refDoc = database.collection("Users2").document(userId)
        refDoc.getDocument{ (document, err) in
            let result = Result {
                
                try document?.data(as: User.self)
                
            }
            switch result {
            case .success(let user):
                if let user = user {
                    let email = user.email
                    let name = user.name
                    let followers = user.followers
                    let likes = user.likes
                    let title = user.title
                    let about = user.about
                    let industry = user.industry
                    let profileImageUrl = user.profileImageUrl
                    
                    
                    self.profile = User (email: email, name: name, followers: followers, likes: likes, title: title, about: about, industry: industry, profileImageUrl: profileImageUrl)
                    print("User : \(user)")
                } else {
                    print("Document does not exist")
                }
            case .failure(let error):
                print("Error decoding user: \(error)")
            }
        }
    }
    
    func updateProfile(id: String, name: String, title: String, email: String, about: String, profileImageUrl: String) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }
        
        let refDoc = database.collection("Users2").document(uid)
        refDoc.getDocument{ (document, err) in
            _ = Result {
                try document?.data(as: User.self)
            }
        }
        database.document(id).updateData([
            name : name,
            title : title,
            email : email,
            about : about,
            profileImageUrl : profileImageUrl
        ]) { (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("Update data Success")
            }
        }
    }
    
    
}
