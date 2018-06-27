//
//  AuthViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 6/26/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    // TODO: - Check is the user did logged in breofre
    // If did use the token to authanticated the user
    // else ask them to login.
    @IBOutlet weak var loginButoon: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonsActions()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
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