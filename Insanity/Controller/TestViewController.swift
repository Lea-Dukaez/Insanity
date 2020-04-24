//
//  TestViewController.swift
//  Insanity
//
//  Created by Léa on 24/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
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
        
//        save data to firastore
        
        
        // dismiss view
        self.navigationController?.popViewController(animated: true)
        
    }
    

}
