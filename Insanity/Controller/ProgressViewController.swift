//
//  ProgressViewController.swift
//  Insanity
//
//  Created by Léa on 24/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
        
    let dataManager = DataManager()
    
    var userName = K.userCell.malekLabel
    var avatarImg = K.userCell.malekAvatar

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLabel.text = userName
        userImage.image = UIImage(named: avatarImg)
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.workout.workoutCellNibName, bundle: nil), forCellReuseIdentifier: K.workout.workoutCellIdentifier)
    }
    
    
}

extension ProgressViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.dataWorkout.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.workout.workoutCellIdentifier, for: indexPath) as! WorkoutCell
        
        if indexPath.row == 0 {
            cell.workoutMoveLabel.text = ""
            cell.oldDataLabel.text = "06/04"
            cell.newDataLabel.text = "18/04"
            cell.percentLabel.text = "%"
            cell.oldDataLabel.textColor = .white
            cell.newDataLabel.textColor = .white
            cell.percentLabel.textColor = .white
            
        } else {
            cell.workoutMoveLabel.text = K.workout.workoutMove[indexPath.row-1]
            cell.oldDataLabel.text = dataManager.dataWorkout[indexPath.row-1].oldNumber
            cell.newDataLabel.text = dataManager.dataWorkout[indexPath.row-1].newNumber
            cell.percentLabel.text = dataManager.Percent(old: dataManager.dataWorkout[indexPath.row-1].oldNumber, new: dataManager.dataWorkout[indexPath.row-1].newNumber)
        }


        return cell
        
    }
    
    
}
