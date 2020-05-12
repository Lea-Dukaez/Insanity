//
//  AccountViewController.swift
//  Insanity
//
//  Created by Léa on 12/05/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {

    var avatarImage = ""
    @IBOutlet weak var pseudoTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    let alert = UIAlertController(title: "Incomplete", message: "Please enter a pseudo and choose an avatar", preferredStyle: UIAlertController.Style.alert)
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pseudoTextField.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
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
    
    
    @IBAction func validatePressed(_ sender: UIButton) {
  
        if pseudoTextField.text?.isEmpty == false &&  avatarImage != "" {
            print(avatarImage)
            print(pseudoTextField.text!)
            // save pseudo and image into firestore
            performSegue(withIdentifier: K.segueAccountToHome, sender: self)
            
        } else {
            showAlert()
        }
        
    }
    
    func showAlert() {
        self.present(alert, animated: true) {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlert))
            self.alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func dismissAlert() {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension AccountViewController:  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return K.avatarImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.reuseAvatarIdentifier, for: indexPath) as! AvatarCollectionViewCell
        
        cell.avatarCellImage.image = UIImage(named: K.avatarImages[indexPath.item])
        
        return cell
    }

}

extension AccountViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        avatarImage = K.avatarImages[indexPath.item]
        
    }

}

extension AccountViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        //Limit the character count to 3.
        if ((textField.text!) + string).count > 25 {
            return false
        }

        return true
    }
}
