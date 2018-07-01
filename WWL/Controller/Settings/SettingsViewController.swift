//
//  SettingsViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/1/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit
import Firebase
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signOutCurrentUser(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            debugPrint("signOut Done")
            // Navigate to main View Contoller
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.performSegue(withIdentifier: Identifiers.AuthViewControllerScene , sender: self)
            }
        } catch let error {
            print(error)
        }
    }
}
