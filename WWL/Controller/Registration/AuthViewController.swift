//
//  AuthViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 6/26/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit
import Firebase
class AuthViewController: UIViewController {
    

    @IBOutlet weak var loginButoon: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonsActions()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        // TODO: - Check is the user did logged in breofre
        // If did use the token to authanticated the user
        // else ask them to login.
//        Auth.auth().addStateDidChangeListener { auth, user in
//            if user != nil {
//                print("User is signed in.")
//                self.performSegue(withIdentifier: Identifiers.ViewController, sender: nil)
//            } else {
//                print("User is signed out.")
//            }
//        }
    }
    fileprivate func setButtonsActions(){
        self.loginButoon.addTarget(self, action: #selector(handelLogin), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(handelSignUp), for: .touchUpInside)
    }
    @objc func handelLogin(){
        debugPrint("handelLogin was press")
        self.navigationController?.navigationBar.isHidden = false
    }
    @objc func handelSignUp(){
        debugPrint("handelSignUp was press")
        self.navigationController?.navigationBar.isHidden = false
    }
}
