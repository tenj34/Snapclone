//
//  SignInViewController.swift
//  Snapclone
//
//  Created by Juan Tenezaca on 2/6/18.
//  Copyright © 2018 Juan Tenezaca. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func turnUpTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print ("We are attempting to sign in")
            
            if error != nil{
                print ("We have an error:\(String(describing: error))")
                
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print ("Attempting to create a user")
                    if error != nil {
                        print ("We have an error:\(String(describing: error))")
                    } else {
                        print("User was created succesfully")
                        
                        Database.database().reference().child("Users").child(user!.uid).child("email").setValue(user!.email)
                        self.performSegue(withIdentifier: "signinsegue", sender: nil)
                    }
                })
                
            } else {
                print ("Signed in succesfully")
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
            }
        }
    }
}
