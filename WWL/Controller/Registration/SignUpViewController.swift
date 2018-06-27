//
//  SignUpViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 6/26/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit
import SafariServices
import Firebase
//import FirebaseAuth

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
        self.createaAccountButton.layer.cornerRadius = 5
        
        let title = "Sign Up"
        let color = UIColor(red:0.35, green:0.66, blue:0.89, alpha:1.0)
        UINavigationController().setTitleAndColor(for: self.navigationController!, itme: self.navigationItem, title: title, color: color)
    }
    
    @IBAction func createaAccountButton(_ sender: UIButton) {
        //        debugPrint("createaAccountButton was pressed")
        guard let userName = userNameInput.text else {return}
        guard let email = emailInput.text else {return}
        guard let password = passWordInput.text else {return}
        
        if userName == "" {
            userNameInput.placeholder = AlertsMessages.requiredFiled
            errorHighlightTextField(textField: userNameInput)
        } else if  email == "" {
            removeErrorHighlightTextField(textField: userNameInput)
            emailInput.placeholder = AlertsMessages.requiredFiled
            errorHighlightTextField(textField: emailInput)
        } else if password == "" {
            removeErrorHighlightTextField(textField: emailInput)
            passWordInput.placeholder = AlertsMessages.requiredFiled
            errorHighlightTextField(textField: passWordInput)
        } else {
            removeErrorHighlightTextField(textField: passWordInput)
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if error != nil {
                    if let errorMessage = error?.localizedDescription {
                        let errorAlert = UIAlertController().alertMessages(title: AlertsMessages.Error, message: errorMessage)
                        if errorMessage == AlertsMessages.emilBadFormt {
                            removeErrorHighlightTextField(textField: self.userNameInput)
                            errorHighlightTextField(textField: self.emailInput)
                        } else if errorMessage == AlertsMessages.passwordLength {
                            removeErrorHighlightTextField(textField: self.userNameInput)
                            removeErrorHighlightTextField(textField: self.emailInput)
                            errorHighlightTextField(textField: self.passWordInput)
                        } else {
                            removeErrorHighlightTextField(textField: self.userNameInput)
                            removeErrorHighlightTextField(textField: self.emailInput)
                            removeErrorHighlightTextField(textField: self.passWordInput)
                        }
                        self.present(errorAlert, animated: true, completion: nil)
                    }
                }
                // MARK: if successfully logged in a user ... naviagte the user to the login page
                let successAlert = UIAlertController().alertMessages(title: AlertsMessages.Successful, message: AlertsMessages.successfulMessage)
                self.present(successAlert, animated: true, completion: {
                    // On complection push back to the root view
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                })
            }
        }
    }
    
    @IBAction func ViewTermsAndConditions(_ sender: UIButton) {
        let url = "http://www.wordsworthlearning.com/staticpage/terms_of_use"
        guard let requestUrl = URL(string: url) else {
            return
        }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let webPage = SFSafariViewController(url: requestUrl, configuration: config)
        present(webPage, animated: true)
    }
}
