//
//  SignUpViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 6/26/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passWordInput: UITextField!
    @IBOutlet weak var createaAccountButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextIputDelegate()
        
    }
    
    func setTextIputDelegate() {
        self.userNameInput.delegate = self
        self.emailInput.delegate = self
        self.passWordInput.delegate = self
    }
    
    // Dissmiss the keyboard on the Done Button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Set the cornerRadius
        self.containerView.layer.cornerRadius = 5
        self.createaAccountButton.layer.cornerRadius = createaAccountButton.frame.height/2

        let title = "Sign Up"
        let color = UIColor(red:0.35, green:0.66, blue:0.89, alpha:1.0)
        UINavigationController().setTitleAndColor(for: self.navigationController!, itme: self.navigationItem, title: title, color: color)
    }
    
    @IBAction func createaAccountButton(_ sender: UIButton) {
        debugPrint("createaAccountButton was pressed")
    }
}
