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
    var dataPodium: [[Double]] = []

    @IBOutlet weak var topOneLabel: UILabel!
    @IBOutlet weak var topTwoLabel: UILabel!
    @IBOutlet weak var topThreeLabel: UILabel!
    
    @IBOutlet weak var topOneImage: UIImageView!
    @IBOutlet weak var topTwoImage: UIImageView!
    @IBOutlet weak var topThreeImage: UIImageView!
    
    @IBOutlet weak var workoutPickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topOneImage.image = UIImage(named: K.userCell.noOpponentAvatar)
        topOneLabel.text = "X"
        topTwoImage.image = UIImage(named: K.userCell.noOpponentAvatar)
        topTwoLabel.text = "X"
        topThreeImage.image = UIImage(named: K.userCell.noOpponentAvatar)
        topThreeLabel.text = "X"

        workoutPickerView.dataSource = self
        workoutPickerView.delegate = self
        
        recupMaxValues()
    }
    
    func recupMaxValues() {
        dataPodium = []

        db.collection(K.FStore.collectionUsersName)
            .order(by:  K.FStore.idField)
            .getDocuments { (querySnapshot, error) in
                if let err = error {
                    print("Error retrieving document: \(err)")
                    return
                } else if (querySnapshot?.isEmpty)! {
                    print("no data")
                    return
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let maxValues = data[K.FStore.maxField] as? [Double] {
                                self.dataPodium.append(maxValues)
                            } // end if let get data
                        } // end for loop
                    } // end if let snapshotdocuments
                } // end of else ... get data
        } // end GetDocuments
    } // end getPodium
    


    func updatePodium(sportRow: Int) {
        
        let maxScore = dataPodium.max { user1, user2  in user1[sportRow] < user2[sportRow] }
        let indexForPlayerWithMaxScore = dataPodium.indices.filter { dataPodium[$0] == maxScore! } // return array
        let index = indexForPlayerWithMaxScore[0]
        
        topOneImage.image = UIImage(named: K.userCell.usersAvatar[index])
        topOneLabel.text = String(dataPodium[index][sportRow])
        
    }
        
    
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
//        workoutSelected = K.workout.workoutMove[row]

        print("array podium before sorted: \(self.dataPodium)")
        print(row)
//        updatePodium(row: row)

        
    }
    
}


