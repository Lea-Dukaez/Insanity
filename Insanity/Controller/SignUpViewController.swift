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
    
    let alertEmpty = UIAlertController(title: "Error", message: "email/password can't be empty", preferredStyle: UIAlertController.Style.alert)

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func signUpPressed(_ sender: UIButton) {
        
        let textFieldArray = [emailTextField, passwordTextField]
        let allHaveText = textFieldArray.allSatisfy { $0!.text?.isEmpty == false }
        
        if !allHaveText {
            showAlert(for: alertEmpty)
        } else {
            if let email = self.emailTextField.text, let password = self.passwordTextField.text {
                
                Auth.auth().createUser(withEmail: email, password: password) { (dataResult, error) in
                    if let err = error {
                        let errorMsg = "\(err.localizedDescription)"
                        let alertError = UIAlertController(title: "Error", message: errorMsg, preferredStyle: UIAlertController.Style.alert)
                        self.showAlert(for: alertError)
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
    
    func showAlert(for alert: UIAlertController) {
        self.present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlert))
            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func dismissAlert() {
        self.dismiss(animated: true, completion: nil)
    }

}
