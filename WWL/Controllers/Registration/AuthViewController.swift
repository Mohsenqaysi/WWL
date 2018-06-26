//
//  AuthViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 6/26/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var loginButoon: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonsActions()
    }
    fileprivate func setButtonsActions(){
        self.loginButoon.addTarget(self, action: #selector(handelLogin), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(handelSignUp), for: .touchUpInside)
    }
    @objc func handelLogin(){
        debugPrint("handelLogin was press")
    }
    @objc func handelSignUp(){
        debugPrint("handelSignUp was press")
    }
}
