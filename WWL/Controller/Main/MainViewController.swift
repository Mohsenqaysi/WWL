//
//  MainViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/1/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    let userDefult = UserDefaults.standard

    var FirebaseNetworkingCallRef = FirebaseNetworkingCall()
    var ref: DatabaseReference!
    
    var levelsStatus = [LevelStatusModel]() {
        didSet {
            print("levelsStatus: \(levelsStatus)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(userDefult.bool(forKey: Keys.menuSoundKye.rawValue))
        isSoundON(isON: userDefult.bool(forKey: Keys.menuSoundKye.rawValue))
        
        print("new levelsStatus: \(levelsStatus)")
//        FirebaseNetworkingCallRef.getlevelsStatus()
//        levelsStatus = FirebaseNetworkingCallRef.getLevelsStatsArry()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        ref = Database.database().reference()
        getlevelsStatus()
    }
    
    func getlevelsStatus() {
        let userID = FirebaseNetworkingCallRef.getUserID()
        self.ref.child(FirebasePaths.levels_status.toString()).child(userID).observeSingleEvent(of: .value, with: {  (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if let flag = snap.value as?  Int {
                        let key = Int(snap.key)
                        print("key: \(String(describing: key)) - value: \(flag)")
                        let value = flag == 1 ? true : false
                        self.levelsStatus.append(LevelStatusModel(key: key!, flag: value))
                    } else {
                        print("failed to convert")
                    }
                }
            }
        })
    }
    
    @IBAction func startPlayingButton(_ sender: UIButton) {
        sender.bounceButtonEffect()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.LevelsViewControllerSegue {
            if let destination = segue.destination as? LevelsViewController {
                destination.levelsStatus = levelsStatus
            }
        }
    }
    
    @IBAction func settingsButtonHandler(_ sender: UIButton) {
        debugPrint("playButtonHandler")
        sender.bounceButtonEffect()
    }
}
