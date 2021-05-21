//
//  ProfileViewController.swift
//  JustAskIt
//
//  Created by Ufuk Angay on 19/05/2021.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseFirestore


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var jobTitleField: UILabel!
    @IBOutlet weak var industryField: UILabel!
    @IBOutlet weak var contactField: UILabel!
    @IBOutlet weak var aboutField: UILabel!
    
    
    @IBOutlet weak var CircleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserInformation()
        
        // Circle Profile Picture
        CircleImageView.layer.cornerRadius = CircleImageView.frame.size.width/2
        CircleImageView.clipsToBounds = true
    }
    
    func getUserInformation(){
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }
        
        let database = Firestore.firestore()
        let refDoc = database.collection("users").document(uid)
        refDoc.getDocument{ (document, err) in
            if let user = document?.data(){
                self.nameField.text = user["name"] as? String
                self.jobTitleField.text = user["job"] as? String
                self.aboutField.text = user["about"] as? String
                self.industryField.text = user["industry"] as? String
                self.contactField.text = user["contact"] as? String
            }
            else
            {
                print("User not found")
                return
            }
        }
    }
}
