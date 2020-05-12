//
//  ViewController.swift
//  Insanity
//
//  Created by Léa on 23/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController {
    
    var user = K.userCell.usersLabel[0]
    var avatar = K.userCell.usersAvatar[0]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true);

        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.userCell.userCellNibName, bundle: nil), forCellReuseIdentifier: K.userCell.userCellIdentifier)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segueToProgress {
            let progressView = segue.destination as! ProgressViewController
            progressView.userName = user
            progressView.avatarImg = avatar
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        do {
          try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
            return
        }
        
        print("user logged out")
        self.navigationController!.popToRootViewController(animated: true)
    }
    

}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.userCell.usersAvatar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: K.userCell.userCellIdentifier, for: indexPath) as! UserCell

        cell.avatarImage.image = UIImage(named: K.userCell.usersAvatar[indexPath.row])
        cell.userLabel.text = K.userCell.usersLabel[indexPath.row]
   
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        avatar = K.userCell.usersAvatar[indexPath.row]
        user = K.userCell.usersLabel[indexPath.row]
     
        // when click on cell
        performSegue(withIdentifier: K.segueToProgress, sender: self)
    }
    
}

