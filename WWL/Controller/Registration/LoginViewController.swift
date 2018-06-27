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
    }
    
    // Dissmiss the keyboard on the Done Button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.logInButton.layer.cornerRadius = 5
        let title = "Logging"
        let color = UIColor(red:0.76, green:0.18, blue:0.48, alpha:1.0)
        UINavigationController().setTitleAndColor(for: self.navigationController!, itme: self.navigationItem, title: title, color: color)
    }
    
    
    @IBAction func longInUser(_ sender: UIButton) {
        
        
    }
    
    @IBAction func passwordReset(_ sender: UIButton) {
        //  Show an alert input view
        let alertController = UIAlertController(title: "Reseat Password", message: "Enter the email you want to reseat:", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter email"
        }
        // ResetAction handeler
        let resetAction = UIAlertAction(title: "Reseat", style: .default, handler: { alert -> Void in
            if let emailTextField = alertController.textFields?.first {
                guard let email = emailTextField.text else {return}
                print("emailTextField: \(email)")
                // Send the request to the server
                self.reseatPassword(for: email)
            }
        })
        // cancelAction handeler
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(resetAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func reseatPassword(for email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                debugPrint("reseat email error: \(error.debugDescription)")
                let errorAlert = UIAlertController().alertMessages(title: AlertsMessages.Error, message: error.debugDescription)
                self.present(errorAlert, animated: true, completion: nil)
            }
            let successAlert = UIAlertController().alertMessages(title: AlertsMessages.Successful, message: AlertsMessages.successfulReseatMessage)
            self.present(successAlert, animated: true, completion: nil)
        }
    }
}
