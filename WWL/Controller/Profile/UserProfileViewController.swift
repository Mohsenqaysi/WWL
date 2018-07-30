//
//  UserProfileViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/29/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTbaleView: UITableView!
    var FirebaseNetworkingCallRef = FirebaseNetworkingCall()
    var ref: DatabaseReference!
    
    var userProgressArray = [UserProgress](){
        didSet {
            print("userProgressArray: \(userProgressArray)")
            print(userProgressArray.first?.title)
            print(userProgressArray.first?.incorrect_answers)
            print(userProgressArray.first?.total_time)
            print("-------------------------------------")
            
            if userProgressArray.isEmpty {
                self.noDataImage.isHidden = false
            } else {
                self.noDataImage.isHidden = true
            }
        }
    }
    
    // https://wordsworth-learning.firebaseio.com/user_progress/gF6HZq7d9GbBwYJpUklslSupn642
    
    @IBOutlet weak var userNmaelabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var noDataImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userNmaelabel.text = "Mohsen Qaysi"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ref = Database.database().reference()
        getlevelsProgress()
    }
    
    
    func getlevelsProgress() {
        let userID = FirebaseNetworkingCallRef.getUserID()
        self.ref.child(FirebasePaths.user_progress.toString()).child(userID).observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                print("dictionary: \(dictionary.count)")
                print("dictionary: \(dictionary)")
                let key = snapshot.key
                let userProgress = UserProgress(title: key, dictionary: dictionary)
                self.userProgressArray.append(userProgress)

//                print(key)
//                print(userProgress.incorrect_answers!)
//                print(userProgress.total_time!)
                DispatchQueue.main.async {
                    self.profileTbaleView.reloadData()
                }
            }
        }, withCancel: nil)
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UserProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProgressArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return userProgressArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return userProgressArray[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.profileCellID, for: indexPath) as! ProfileCell
        
        if let _ = userProgressArray[indexPath.row].title,
            let total_time = userProgressArray[indexPath.row].total_time,
            let incorrect_answers = userProgressArray[indexPath.row].incorrect_answers {
            cell.inccorectAnswers.text = "\(incorrect_answers)"
            let formated_total_time = Double(exactly: total_time)! / 60
            let time = Double().NSNumberFormater(Double(exactly: total_time)!)
            cell.totalTime.text = "\(time) Mins:Sec"
        }
        return cell
    }
}

extension Double {
    func NSNumberFormater(_ theNumber: Double) -> String {
        let date = Date(timeIntervalSince1970: theNumber)
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        return formatter.string(from: date)
    }
}
