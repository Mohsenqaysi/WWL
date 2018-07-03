//
//  MainViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/1/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let userDefult = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(userDefult.bool(forKey: Keys.menuSoundKye.rawValue))
        isSoundON(isON: userDefult.bool(forKey: Keys.menuSoundKye.rawValue))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func startPlayingButton(_ sender: UIButton) {
        sender.bounceButtonEffect()
    }
    
    @IBAction func settingsButtonHandler(_ sender: UIButton) {
        debugPrint("playButtonHandler")
        sender.bounceButtonEffect()
    }
    
    
}
