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
    
    var pseudoCurrentUser = ""
    var avatarCurrentUser = ""
    
    var pseudo = ""
    var avatar = ""
    
    var dataUsers: [User] = []
    let db = Firestore.firestore()
    
    @IBOutlet weak var competitorsLabel: UILabel!
    @IBOutlet weak var currentUserImage: UIImageView!
    @IBOutlet weak var currentUserLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) { navigationController?.isNavigationBarHidden = true }
    override func viewWillDisappear(_ animated: Bool) { navigationController?.isNavigationBarHidden = false }

    override func viewDidLoad() {

        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true);
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: K.userCell.userCellNibName, bundle: nil), forCellReuseIdentifier: K.userCell.userCellIdentifier)
        
        loadUsers()
    }
    
    func loadUsers() {
        dataUsers = []
    
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                let uid = user.uid
            
                // get other users
                self.db.collection(K.FStore.collectionUsersName)
                    .getDocuments { (querySnapshot, error) in
                        if let err = error {
                            print("Error getting documents: \(err)")
                        } else {
                            // documents exist in Firestore
                            if let snapshotDocuments = querySnapshot?.documents {
                                for doc in snapshotDocuments {
                                    let data = doc.data()
                                     if let pseudo = data[K.FStore.pseudoField] as? String, let avatar = data[K.FStore.avatarField] as? String {
                                        if doc.documentID != uid {
                                            let newUser = User(pseudo: pseudo, avatar: avatar)
                                            self.dataUsers.append(newUser)
                                            // when data is collected, create the tableview
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                                if self.dataUsers.count == 0 {
                                                    self.competitorsLabel.text = "No competitor yet !"
                                                    self.competitorsLabel.textAlignment = .center
                                                } else {
                                                    self.competitorsLabel.text = "Other competitors :"
                                                    self.competitorsLabel.textAlignment = .left
                                                }
                                            }
                                        } else {
                                            self.pseudoCurrentUser = pseudo
                                            self.avatarCurrentUser = avatar
                                            DispatchQueue.main.async {
                                                self.currentUserLabel.text = self.pseudoCurrentUser
                                                self.currentUserImage.image = UIImage(named: self.avatarCurrentUser)
                                            }
                                        }
                                     }

                                }
                            } // fin if let snapshotDoc
                            
                        } // fin else no error ...so access data possible
                    } // fin getDocument
            }
          
        }

    }
    
    @IBAction func currentUserPressed(_ sender: UIButton) {
        avatar = avatarCurrentUser
        pseudo = pseudoCurrentUser
        performSegue(withIdentifier: K.segueToProgress, sender: self)
    }
    
    @IBAction func addTestPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.segueHomeToTest, sender: self)

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


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segueToProgress {
            let progressView = segue.destination as! ProgressViewController
            progressView.userName = pseudo 
            progressView.avatarImg = avatar
        }
        if segue.identifier == K.segueHomeToTest {
            let testView = segue.destination as! TestViewController
            testView.userName = pseudoCurrentUser
            testView.avatarImg = avatarCurrentUser
        }
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataUsers.count)
        return dataUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.userCell.userCellIdentifier, for: indexPath) as! UserCell

        cell.avatarImage.image = UIImage(named: dataUsers[indexPath.row].avatar)
        cell.userLabel.text = dataUsers[indexPath.row].pseudo
   
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell select at : \(indexPath.row)")
        avatar = dataUsers[indexPath.row].avatar
        pseudo = dataUsers[indexPath.row].pseudo
    
        performSegue(withIdentifier: K.segueToProgress, sender: self)
    }
    
}

