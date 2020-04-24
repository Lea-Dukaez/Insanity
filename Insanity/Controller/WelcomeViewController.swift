//
//  ViewController.swift
//  Insanity
//
//  Created by Léa on 23/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var user = K.cell.malekLabel
    var avatar = K.cell.malekAvatar
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.cell.cellNibName, bundle: nil), forCellReuseIdentifier: K.cell.cellIdentifier)
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segueToProgress {
            let progressView = segue.destination as! ProgressViewController
            progressView.userName = user
            progressView.avatarImg = avatar
        }
    }


}


extension WelcomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cell.cellIdentifier, for: indexPath) as! UserCell

        // set the text from the data model
        if indexPath.row == 0 {
            cell.avatarImage.image = UIImage(named: K.cell.malekAvatar)
            cell.userLabel.text = K.cell.malekLabel
        } else if indexPath.row == 1 {
            cell.avatarImage.image =  UIImage(named: K.cell.leaAvatar)
            cell.userLabel.text = K.cell.leaLabel
        }
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            avatar = K.cell.malekAvatar
            user = K.cell.malekLabel
        } else if indexPath.row == 1 {
            avatar =  K.cell.leaAvatar
            user = K.cell.leaLabel
        }
        // when click on cell
        performSegue(withIdentifier: K.segueToProgress, sender: self)
    }
    
}
