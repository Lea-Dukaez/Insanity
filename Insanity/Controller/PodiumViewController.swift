//
//  PodiumViewController.swift
//  Insanity
//
//  Created by Léa on 30/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import UIKit
import Firebase

class PodiumViewController: UIViewController {
    
    var workoutSelected = "Switch Kicks"
    let db = Firestore.firestore()
    var dataPodium: [Workout] = []

    @IBOutlet weak var topOneLabel: UILabel!
    @IBOutlet weak var topTwoLabel: UILabel!
    @IBOutlet weak var topThreeLabel: UILabel!
    
    @IBOutlet weak var topOneImage: UIImageView!
    @IBOutlet weak var topTwoImage: UIImageView!
    @IBOutlet weak var topThreeImage: UIImageView!
    
    @IBOutlet weak var workoutPickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutPickerView.dataSource = self
        workoutPickerView.delegate = self
        
        getPodium()
        
    }
    
    func getPodium() {
        
        db.collection(K.FStore.collectionName)
            .whereField(K.FStore.userField, in: K.FStore.users)
            .order(by: K.FStore.dateField, descending: true).limit(to: 1)
            .getDocuments { (querySnapshot, error) in
            if let err = error {
                print("Error retrieving document: \(err)")
                return
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let userTested = data[K.FStore.userField] as? String, let testResult = data[K.FStore.testField] as? [String], let testDate = data[K.FStore.dateField] as? Timestamp {
                            let newWorkout = Workout(user: userTested, workOutResult: testResult, date: testDate)
                            self.dataPodium.append(newWorkout)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                print("array podium : \(self.dataPodium)")
            }
        } // end GetDocuments

        

    } // end getPodium
    
} // end PodiumViewController

extension PodiumViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return K.workout.workoutMove.count
    }
}

extension PodiumViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: K.workout.workoutMove[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        workoutSelected = K.workout.workoutMove[row]
        
    }
    
}


