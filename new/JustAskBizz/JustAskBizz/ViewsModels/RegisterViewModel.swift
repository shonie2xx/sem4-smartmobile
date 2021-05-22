//
//  RegisterViewModel.swift
//  JustAskBizz
//
//  Created by Aleksandar Lekov on 21/05/2021.
//

import Foundation
import FirebaseAuth

class RegisterViewModel: ObservableObject{
    
    let auth = Auth.auth()
    
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
        }
    }
}
