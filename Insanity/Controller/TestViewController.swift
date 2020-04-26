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

        // Do any additional setup after loading the view.
    }

    @IBAction func validatePressed(_ sender: UIButton) {
        // Lea Data
        leaWorkoutTest.append(leaSKTextField.text!)
        leaWorkoutTest.append(leaPJKTextField.text!)
        leaWorkoutTest.append(leaPKTextField.text!)
        leaWorkoutTest.append(leaPJTextField.text!)
        leaWorkoutTest.append(leaJSQTextField.text!)
        leaWorkoutTest.append(leaSJTextField.text!)
        leaWorkoutTest.append(leaPUJKTextField.text!)
        leaWorkoutTest.append(leaPMCTextField.text!)
        // Malek Data
        malekWorkoutTest.append(malekSKTextField.text!)
        malekWorkoutTest.append(malekPJKTextField.text!)
        malekWorkoutTest.append(malekPKTextField.text!)
        malekWorkoutTest.append(malekPJTextField.text!)
        malekWorkoutTest.append(malekJSQTextField.text!)
        malekWorkoutTest.append(malekSJTextField.text!)
        malekWorkoutTest.append(malekPUJKTextField.text!)
        malekWorkoutTest.append(malekPMCTextField.text!)
        
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
    }
    
}
