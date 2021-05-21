//
//  AuthViewModel.swift
//  JustAskBiz
//
//  Created by Aleksandar Lekov on 21/05/2021.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject{
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            // success
            print("success")
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email,
                    password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            // success
            print("success")
        }
    }
    
}
