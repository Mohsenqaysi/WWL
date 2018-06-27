//
//  LoginViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 6/26/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passWordInput: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailInput.delegate = self
        self.passWordInput.delegate = self
        //        passWordInput.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    //    @objc func textFieldDidChange(_ textField: UITextField) {
    //
    //    }
    
    // Dissmiss the keyboard on the Done Button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.logInButton.backgroundColor = .lightGray
        logInButton.isEnabled = false
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error)
        }
        self.logInButton.layer.cornerRadius = 5
        let title = "Logging"
        UINavigationController().setTitleAndColor(for: self.navigationController!, itme: self.navigationItem, title: title, color: PinkColor)
    }
    
    
    @IBAction func longInUser(_ sender: UIButton) {
        
        guard let email = emailInput.text, emailInput.text != "" else {
            return
        }
        guard let password = passWordInput.text, passWordInput.text != "" else {
            return
        }
        removeErrorHighlightTextField(textField: passWordInput)
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                if let errorMessage = error?.localizedDescription {
                    let errorAlert = UIAlertController().alertMessages(title: AlertsMessages.Error, message: errorMessage)
                    self.present(errorAlert, animated: true, completion: nil)
                }
            }
            
            let user = Auth.auth().currentUser
            guard let currentUser = user, user != nil else {return}
            let uid = currentUser.uid
            let userEmail = currentUser.email
            debugPrint("uid: \(uid) and email: \(String(describing: userEmail))")
            // Navigate to main View Contoller
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.performSegue(withIdentifier: Identifiers.ViewController , sender: self)
            }
        }
    }
    
    @IBAction func passwordReset(_ sender: UIButton) {
        //  Show an alert input view
        let alertController = UIAlertController(title: "Reset Password", message: "Enter the email you want to Reset:", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter email"
        }
        // ResetAction handeler
        let resetAction = UIAlertAction(title: "Reset", style: .default, handler: { alert -> Void in
            if let emailTextField = alertController.textFields?.first {
                guard let email = emailTextField.text else {return}
                print("emailTextField: \(email)")
                // Send the request to the server
                self.ResetPassword(for: email)
            }
        })
        // cancelAction handeler
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(resetAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func ResetPassword(for email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                if let errorMessage = error?.localizedDescription {
                    let errorAlert = UIAlertController().alertMessages(title: AlertsMessages.Error, message: errorMessage)
                    self.present(errorAlert, animated: true, completion: nil)
                }
            }
            let successAlert = UIAlertController().alertMessages(title: AlertsMessages.Successful, message: AlertsMessages.successfulResetMessage)
            self.present(successAlert, animated: true, completion: nil)
        }
    }
}

extension LoginViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         sendButtonValidation()
        print("shouldChangeCharactersIn")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        sendButtonValidation()
        print("textFieldDidEndEditing")
    }
    
    fileprivate func sendButtonValidation() {
        //        if (emailInput && passWordInput.text?.isEmpty) {
        guard let email = emailInput.text else {return}
        guard let password = passWordInput.text else {return}
        debugPrint("Email: \(email) - Password: \(password)")
        debugPrint("Email: \(email.count) - Password: \(password.count)")

        if email.count > 0 && password.count > 5 {
            //            if (email != "" && password != "") {
            self.logInButton.backgroundColor = PinkColor
            logInButton.isEnabled = true
        } else {
            self.logInButton.backgroundColor = .lightGray
            logInButton.isEnabled = false
        }
        //    }
    }
}
