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
        
        let dataPodiumFiltered = dataPodium.filter { $0.isEmpty == false }

        switch dataPodiumFiltered.count {
        case 1:
            // case only 1 array Max not empty => Data for 1 user
            let index = dataPodium.indices.filter { dataPodium[$0] == dataPodiumFiltered[0] } // return array with 1 element
            topOneImage.image = UIImage(named: K.userCell.usersAvatar[index[0]])
            topOneLabel.text = String(format: "%.0f", dataPodium[index[0]][sportRow])
        
        case 2:
            // case 2 array Max not empty => Data for 2 users
            let maxScore = dataPodiumFiltered.max { user1, user2  in user1[sportRow] < user2[sportRow] }
            let index = dataPodium.indices.filter { dataPodium[$0] == maxScore! }
            topOneImage.image = UIImage(named: K.userCell.usersAvatar[index[0]])
            topOneLabel.text = String(format: "%.0f", dataPodium[index[0]][sportRow])
            if index.count == 2 {
                topTwoImage.image = UIImage(named: K.userCell.usersAvatar[index[1]])
                topTwoLabel.text = String(format: "%.0f", dataPodium[index[1]][sportRow])
            } else {
                let secondScore = dataPodiumFiltered.filter { $0 != maxScore }
                let indexSecond = dataPodium.indices.filter { dataPodium[$0] == secondScore[0] }
                topTwoImage.image = UIImage(named: K.userCell.usersAvatar[indexSecond[0]])
                topTwoLabel.text = String(format: "%.0f", dataPodium[indexSecond[0]][sportRow])
            }
        
        case 3...4:
            // case 3 or 4 array Max not empty => Data for 3 users
            let maxScore = dataPodiumFiltered.max { user1, user2  in user1[sportRow] < user2[sportRow] }
            let index = dataPodium.indices.filter { dataPodium[$0] == maxScore! }
            topOneImage.image = UIImage(named: K.userCell.usersAvatar[index[0]])
            topOneLabel.text = String(format: "%.0f", dataPodium[index[0]][sportRow])
            if index.count == 3 || index.count == 4 {
                topTwoImage.image = UIImage(named: K.userCell.usersAvatar[index[1]])
                topTwoLabel.text = String(format: "%.0f", dataPodium[index[1]][sportRow])
                topThreeImage.image = UIImage(named: K.userCell.usersAvatar[index[2]])
                topThreeLabel.text = String(format: "%.0f", dataPodium[index[2]][sportRow])
            } else if index.count == 2 {
                topTwoImage.image = UIImage(named: K.userCell.usersAvatar[index[1]])
                topTwoLabel.text = String(format: "%.0f", dataPodium[index[1]][sportRow])
            } else {
                let dataPodiumWithouFirst = dataPodiumFiltered.filter { $0 != maxScore }
                let SecondMaxScore = dataPodiumWithouFirst.max { user1, user2  in user1[sportRow] < user2[sportRow] }
                let indexSecond = dataPodium.indices.filter { dataPodium[$0] == SecondMaxScore! }
                topTwoImage.image = UIImage(named: K.userCell.usersAvatar[indexSecond[0]])
                topTwoLabel.text = String(format: "%.0f", dataPodium[indexSecond[0]][sportRow])
                if indexSecond.count == 2 || index.count == 3 {
                    topThreeImage.image = UIImage(named: K.userCell.usersAvatar[indexSecond[1]])
                    topThreeLabel.text = String(format: "%.0f", dataPodium[indexSecond[1]][sportRow])
                } else {
                    let dataPodiumThird = dataPodiumWithouFirst.filter { $0 != SecondMaxScore }
                    let thirdMaxScore = dataPodiumThird.max { user1, user2  in user1[sportRow] < user2[sportRow] }
                    let indexThird = dataPodium.indices.filter { dataPodium[$0] == thirdMaxScore! }
                    topThreeImage.image = UIImage(named: K.userCell.usersAvatar[indexThird[0]])
                    topThreeLabel.text = String(format: "%.0f", dataPodium[indexThird[0]][sportRow])
                }
            }
        default:
            // case if dataPodium contains only empty array => dataPodiumFiltered.count = 0
            print("no data recorded")
        }
        
        
 
//            let maxScore = dataPodium.max { user1, user2  in user1[sportRow] < user2[sportRow] }
//            let indexForPlayerWithMaxScore = dataPodium.indices.filter { dataPodium[$0] == maxScore! } // return array
//            let index = indexForPlayerWithMaxScore[0]
//
//            topOneImage.image = UIImage(named: K.userCell.usersAvatar[index])
//            topOneLabel.text = String(dataPodium[index][sportRow])
//
//
//
        
//        let nonTopOne = dataPodium.filter { $0 != maxScore }
//        let secMaxScore = dataPodium.max { user1, user2  in user1[sportRow] < user2[sportRow] }
//        let indexForPlayerWithSecMaxScore = dataPodium.indices.filter { dataPodium[$0] == secMaxScore! } // return array
        
    }
        
    
} // end PodiumViewController


extension PodiumViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return K.workout.workoutMove.count+1
    }
}

extension PodiumViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if row == 0 {
            let attributedString = NSAttributedString(string: "** Please select below **", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            return attributedString
        }
        
        let attributedString = NSAttributedString(string: K.workout.workoutMove[row-1], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        workoutSelected = K.workout.workoutMove[row]

//        print("array podium before sorted: \(self.dataPodium)")
//        print(row)
        if row != 0 {
            updatePodium(sportRow: row-1)
        }
    }
    
}


