//
//  ProgressViewController.swift
//  Insanity
//
//  Created by Léa on 24/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import UIKit
import Firebase

class ProgressViewController: UIViewController {
        
    let db = Firestore.firestore()
    
    var dataWorkoutTest: [WorkoutTest] = []
//    var malekDataWorkoutTest: [WorkoutTest] = []
    
    var userName = K.userCell.malekLabel
    var avatarImg = K.userCell.malekAvatar

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLabel.text = userName
        userImage.image = UIImage(named: avatarImg)
        
        loadWorkoutData()
        
        DispatchQueue.main.async {
            self.tableView.dataSource = self
            self.tableView.register(UINib(nibName: K.workout.workoutCellNibName, bundle: nil), forCellReuseIdentifier: K.workout.workoutCellIdentifier)
        }
    }
    
    func loadWorkoutData() {

        dataWorkoutTest = []

        // retrieve data for Malek
        if userName == K.userCell.malekLabel {
            db.collection(K.FStore.collectionName)
                .order(by: K.FStore.dateField).limit(to: 2)
                .whereField(K.FStore.userField, isEqualTo: K.FStore.malekUser)
                .getDocuments() { (querySnapshot, error) in
                    if let err = error {
                        print("Error getting documents: \(err)")
                    } else {
                        if let snapshotDocuments = querySnapshot?.documents {
                            for doc in snapshotDocuments {
                                let data = doc.data()
                                if let userTested = data[K.FStore.userField] as? String, let testResult = data[K.FStore.testField] as? [String], let testDate = data[K.FStore.dateField] as? Timestamp {
                                    let newWorkoutTest = WorkoutTest(user: userTested, workOutResult: testResult, date: testDate)
                                    self.dataWorkoutTest.append(newWorkoutTest)
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                        }
                    }
            }
        } // retrieve data for Lea
        else if userName == K.userCell.leaLabel {
            db.collection(K.FStore.collectionName)
                .order(by: K.FStore.dateField).limit(to: 2)
                .whereField(K.FStore.userField, isEqualTo: K.FStore.leaUser)
                .getDocuments() { (querySnapshot, error) in
                    if let err = error {
                        print("Error getting documents: \(err)")
                    } else {
                        if let snapshotDocuments = querySnapshot?.documents {
                            for doc in snapshotDocuments {
                                let data = doc.data()
                                if let userTested = data[K.FStore.userField] as? String, let testResult = data[K.FStore.testField] as? [String], let testDate = data[K.FStore.dateField] as? Timestamp {
                                    let newWorkoutTest = WorkoutTest(user: userTested, workOutResult: testResult, date: testDate)
                                    self.dataWorkoutTest.append(newWorkoutTest)
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                        }

                    }
                }
            }
    }
    
    func Percent(old: String, new: String, cellForPercent: WorkoutCell) -> String {
        let oldValue = Double(old)!
        let newValue = Double(new)!
        let percent: Double = ((newValue - oldValue) / oldValue) * 100
        let percentString = String(format: "%.0f", percent)
        
        if percent>=0 {
            cellForPercent.percentLabel.textColor = .green
            return "+"+percentString+"%"
        } else {
            cellForPercent.percentLabel.textColor = .red
            return percentString+"%"
        }
    }
    
    func dateString(timeStampDate: Timestamp) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        let date = timeStampDate.dateValue()
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    
}

extension ProgressViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.workout.workoutMove.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.workout.workoutCellIdentifier, for: indexPath) as! WorkoutCell
        
        if indexPath.row == 0 {
            cell.workoutMoveLabel.text = ""
            cell.oldDataLabel.text = dateString(timeStampDate: dataWorkoutTest[0].date)
            cell.newDataLabel.text = dateString(timeStampDate: dataWorkoutTest[1].date)
            cell.percentLabel.text = "%"
            cell.oldDataLabel.textColor = .white
            cell.newDataLabel.textColor = .white
            cell.percentLabel.textColor = .white
        } else {
            cell.workoutMoveLabel.text = K.workout.workoutMove[indexPath.row-1]
            cell.oldDataLabel.text = dataWorkoutTest[0].workOutResult[indexPath.row-1]
            cell.newDataLabel.text = dataWorkoutTest[1].workOutResult[indexPath.row-1]
            cell.percentLabel.text = Percent(old: dataWorkoutTest[0].workOutResult[indexPath.row-1], new: dataWorkoutTest[1].workOutResult[indexPath.row-1], cellForPercent: cell)
        }
        return cell
    }
}
 
