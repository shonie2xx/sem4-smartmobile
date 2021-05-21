//
//  Service.swift
//  JustAskIt
//
//  Created by Ufuk Angay on 15/05/2021.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseFirestore

class Service {
    
    static func signUpUser(email: String, password: String, name: String, job: String, about: String, contact: String, industry: String, onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let auth = Auth.auth()
        
        auth.createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                onError(error!)
                return
            }
            
            uploadToDatabase(email: email, name: name, job: job, about: about, contact : contact, industry : industry, onSuccess: onSuccess)
        }
    }
    
    static func uploadToDatabase(email: String, name: String, job: String, about: String, contact: String, industry : String, onSuccess: @escaping () -> Void) {
        let uid = Auth.auth().currentUser?.uid
        let database = Firestore.firestore()
        
        database.collection("users").document(uid!).setData(["name" : name, "email" : email, "job" : job, "about" : about, "contact" : contact, "industry" : industry]) { (error) in
            if error != nil{
            }
        }
        onSuccess()
    }
    
    
    static func getUserInfoHome(onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let ref = Database.database().reference()
        let defaults = UserDefaults.standard
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }
        
        ref.child("users").child(uid).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let email = dictionary["email"] as! String
                let name = dictionary["name"] as! String
                
                defaults.set(email, forKey: "userEmailKey")
                defaults.set(name, forKey: "userNameKey")
                
                onSuccess()
            }
        }) { (error) in
            onError(error)
        }
    }
    
    static func createAlertController(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        
        return alert
    }
}
