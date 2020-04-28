//
//  TestViewController.swift
//  Insanity
//
//  Created by Léa on 24/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import UIKit
import Firebase

class TestViewController: UIViewController {
    
    let db = Firestore.firestore()
    var leaWorkoutTest = [String]()
    var malekWorkoutTest = [String]()
    var textFieldArray = [UITextField]()
    let alert = UIAlertController(title: "Incomplet", message: "Merci de remplir tous les exercices", preferredStyle: UIAlertController.Style.alert)
    
    @IBOutlet weak var validateButton: UIButton!
    
    @IBOutlet weak var leaSKTextField: UITextField!
    @IBOutlet weak var malekSKTextField: UITextField!
    @IBOutlet weak var leaPJKTextField: UITextField!
    @IBOutlet weak var malekPJKTextField: UITextField!
    @IBOutlet weak var leaPKTextField: UITextField!
    @IBOutlet weak var malekPKTextField: UITextField!
    @IBOutlet weak var leaPJTextField: UITextField!
    @IBOutlet weak var malekPJTextField: UITextField!
    @IBOutlet weak var leaJSQTextField: UITextField!
    @IBOutlet weak var malekJSQTextField: UITextField!
    @IBOutlet weak var leaSJTextField: UITextField!
    @IBOutlet weak var malekSJTextField: UITextField!
    @IBOutlet weak var leaPUJKTextField: UITextField!
    @IBOutlet weak var malekPUJKTextField: UITextField!
    @IBOutlet weak var leaPMCTextField: UITextField!
    @IBOutlet weak var malekPMCTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        validateButton.isEnabled = false

        textFieldArray = [leaSKTextField, malekSKTextField, leaPJKTextField, malekPJKTextField, leaPKTextField, malekPKTextField, leaPJTextField, malekPJTextField, leaJSQTextField, malekJSQTextField, leaSJTextField, malekSJTextField, leaPUJKTextField, malekPUJKTextField, leaPMCTextField, malekPMCTextField]

        for textField in textFieldArray {
            textField.delegate = self
            textField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        }
        
    }
    
    @IBAction func FallbackButtonTapped(_ sender: UIButton) {
        showAlert()
    }
    
    @IBAction func validatePressed(_ sender: UIButton) {
        
        let allHaveText = textFieldArray.allSatisfy { $0.text?.isEmpty == false }
        
        if allHaveText {
            for textField in textFieldArray {
                if textFieldArray.firstIndex(where: {$0 == textField})! % 2 == 0 {
                    leaWorkoutTest.append(textField.text!)
                } else {
                    malekWorkoutTest.append(textField.text!)
                }
            }
            // Add a new document in Firestore for Lea
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.userField: K.FStore.leaUser,
                K.FStore.testField: leaWorkoutTest,
                K.FStore.dateField: Timestamp(date: Date())
            ]) { error in
                if let err = error {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added!")
                    self.leaWorkoutTest = [String]()
                }
            }
            // Add a new document in Firestore for Malek
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.userField: K.FStore.malekUser,
                K.FStore.testField: malekWorkoutTest,
                K.FStore.dateField: Timestamp(date: Date())
            ]) { error in
                if let err = error {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added!")
                    self.malekWorkoutTest = [String]()
                }
            }
            // dismiss view
            self.navigationController?.popViewController(animated: true)
            
        } else {
            showAlert()
        }
    }
    
    
    func showAlert() {
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.dismissAlert), userInfo: nil, repeats: false)
    }
    
    @objc func dismissAlert() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func doneButtonClicked(_ sender: UITextField) {
        if sender == malekPMCTextField {
            sender.resignFirstResponder()
        } else {
            if let senderIndex = textFieldArray.firstIndex(where: {$0 == sender}) {
                textFieldArray[senderIndex+1].becomeFirstResponder()
            }
        }
    }
    
}

extension TestViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if text.isEmpty {
            validateButton.isEnabled = false
            return true
        } else {
            if let _ = Int(string) {
            } else {
                validateButton.isEnabled = false
                return false
            }
            if text.count > 3 {
                return false
            }
        }

        validateButton.isEnabled = true
        return true
    }
}
