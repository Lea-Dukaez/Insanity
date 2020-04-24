//
//  ProgressViewController.swift
//  Insanity
//
//  Created by Léa on 24/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    var userName = K.cell.malekLabel
    var avatarImg = K.cell.malekAvatar

    @IBOutlet weak var userImage: UIImageView! 
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        userLabel.text = userName
        userImage.image = UIImage(named: avatarImg)
    }
    
}
