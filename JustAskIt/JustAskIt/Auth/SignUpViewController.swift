//
//  SignUpViewController.swift
//  JustAskIt
//
//  Created by Ufuk Angay on 14/05/2021.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextViewDelegate{
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var aboutField: UITextView!
    @IBOutlet weak var contactField: UITextField!
    @IBOutlet weak var jobTitleField: UITextField!
    @IBOutlet weak var industryField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutField.text = "Describe yourself"
        aboutField.textColor = UIColor.lightGray
        aboutField.returnKeyType = .done
        aboutField.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Describe yourself" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Describe yourself"
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func signUpButton_Tapped(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        Service.signUpUser(email: emailField.text!, password: passwordField.text!, name: nameField.text!, job: jobTitleField.text!, about: aboutField.text!, contact: contactField.text!, industry : industryField.text!, onSuccess: {
            defaults.set(true, forKey: "isUserSignedIn")
            self.performSegue(withIdentifier: "userSignedUpSegue", sender: nil)
        }) { (error) in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
        }
    }
    
}
