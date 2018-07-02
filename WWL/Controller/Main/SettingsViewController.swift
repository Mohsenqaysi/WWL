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
    
    let userDefult = UserDefaults.standard
    @IBOutlet weak var soundIsON: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        soundIsON.setOn(userDefult.bool(forKey: Keys.menuSoundKye.rawValue), animated: true)
        isSoundON(isON: userDefult.bool(forKey: Keys.menuSoundKye.rawValue))
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signOutCurrentUser(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: Keys.isLoggedIn.rawValue)
            UserDefaults.standard.synchronize()
            let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Identifiers.AuthViewControllerScene) as! AuthViewController
            UIApplication.shared.keyWindow?.rootViewController?.navigationController?.setViewControllers([newViewController], animated: true)
            self.present(newViewController, animated: true, completion: nil)

        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! LoginViewController
        destinationVC.navigationBarState = false
    }
    
    @IBAction func soundIsPlaying(_ sender: UISwitch) {
        debugPrint("ISON:\(sender.isOn)")
        soundIsON.setOn(sender.isOn, animated: true)
        userDefult.set(sender.isOn, forKey: Keys.menuSoundKye.rawValue)
        userDefult.synchronize()
        isSoundON(isON: sender.isOn)
    }
}


