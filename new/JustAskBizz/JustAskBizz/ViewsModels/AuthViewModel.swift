//
//  LoginViewModel.swift
//  JustAskBizz
//
//  Created by Aleksandar Lekov on 21/05/2021.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject{
    
    let auth = Auth.auth()
    
//    @Published 	var signedIn = false
//
//    var isSignedIn: Bool {
//        return auth.currentUser != nil
//    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            // success
            
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email,
                    password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            // success
            //create user document in firestore
            
        }
    }
    
    func createFirestoreUser(userId:String,email:String,name:String,followers:Int,likes:Int,title:String)
    {
      var user: User = User(userId: userId, email: email, name: name, followers: followers, likes: likes, title: title)
        
    }
}
