//
//  UserService.swift
//  JustAskIt
//
//  Created by Aleksandar Lekov on 20/05/2021.
//

import Foundation
import Firebase
import FirebaseFirestore

class UserService {
    
    private init() {}
    static let shared = UserService()
    
    let userReference = Firestore.firestore().collection("users")
    
    func configure(){
        FirebaseApp.configure()
    }
    
    func create(){
        
    }
    
    func read(){
        
    }
    
    func update(){
        
    }
    
    func delete(){
        
    }
    
}
