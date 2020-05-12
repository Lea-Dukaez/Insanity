//
//  SignInViewController.swift
//  Insanity
//
//  Created by Léa on 12/05/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
    }
    

    @IBAction func signUpPressed(_ sender: UIButton) {
        
        let textFieldArray = [emailTextField, passwordTextField]
        let allHaveText = textFieldArray.allSatisfy { $0!.text?.isEmpty == false }
        
        if !allHaveText {
            self.errorLabel.text = "email/password can't be empty"
            Timer.scheduledTimer(withTimeInterval: 3.0 , repeats: false) { (timer) in
                self.errorLabel.text = ""
            }
        } else {
            if let email = self.emailTextField.text, let password = self.passwordTextField.text {
                
                Auth.auth().createUser(withEmail: email, password: password) { (dataResult, error) in
                    if let err = error {
                        self.errorLabel.text = "\(err.localizedDescription)"
                        Timer.scheduledTimer(withTimeInterval: 3.0 , repeats: false) { (timer) in
                            self.errorLabel.text = ""
                        }
                        return
                    }
                    
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: K.segueToAccount, sender: self)
                    print("user sign up !")
                }
            }
            
        }
    }

}
