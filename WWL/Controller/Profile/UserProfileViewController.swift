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
    
    var userProgressArray2 = [UserProgress]() {
        didSet {
//            if userProgressArray.isEmpty {
//                self.noDataImage.isHidden = false
//            } else {
//                self.noDataImage.isHidden = true
//            }
        }
    }
    
    var userProgressArray = [LevelProgress](){
        didSet {
//            print("userProgressArray: \(userProgressArray)")
//            print(userProgressArray.first?.title)
//            print(userProgressArray.first?.incorrect_answers)
//            print(userProgressArray.first?.total_time)
//            print("-------------------------------------")
            
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
        ref = Database.database().reference()
         getlevelsProgress()
        self.userNmaelabel.text = "Mohsen Qaysi"
        self.noDataImage.isHidden = true
        profileTbaleView.allowsSelection = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func getlevelsProgress() {
        userProgressArray2.removeAll()
        let userID = FirebaseNetworkingCallRef.getUserID()
        var valueList = [NSNumber]()
        var sectionKey: String!
//        self.ref.child(FirebasePaths.user_progress.toString()).child(userID).observe(.childAdded, with: { (snapshot) in
//            if let dictionary = snapshot.value as? [String : AnyObject] {
//                sectionKey = snapshot.key
//                print("dictionary count: \(dictionary.count)")
//                for each in dictionary.values {
//                    valueList.append(each as! NSNumber)
//                    //                    let incorrect_answers = each.value["incorrect_answers"]
//                    //                    let total_time = each.value["total_time"]
//                    //                    print(incorrect_answers)
//                    //                    print(total_time)
//                }
//                print(valueList[0])
//                print(valueList[1])
//                self.userProgressArray.append(LevelProgress(section: sectionKey, incorrect_answers: valueList[0], total_time: valueList[1]))
//                DispatchQueue.main.async {
//                    self.profileTbaleView.reloadData()
//                }
//            }
//        })
//    }
        
        
        self.ref.child(FirebasePaths.user_progress.toString()).child(userID).observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                print("dictionary: \(dictionary.count)")
                print("dictionary: \(dictionary)")
                let key = snapshot.key
                let userProgress = UserProgress(title: key, dictionary: dictionary)
                print("userProgressArray2: \(userProgress)")
                self.userProgressArray2.append(userProgress)
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
        print(" numberOfRowsInSection: \(userProgressArray2.count)")
        return userProgressArray2.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.profileCellID, for: indexPath) as! ProfileCell
        
//        let total_time = userProgressArray[indexPath.row].total_time
//        let time = Double().NSNumberFormater(Double(exactly: total_time)!)
//        let incorrect_answers = userProgressArray[indexPath.row].incorrect_answers
//        cell.sectionLabel.text =  userProgressArray[indexPath.row].section.uppercased()
//        cell.totalTime.text = time//"\(total_time)"
//        cell.inccorectAnswers.text = "\(incorrect_answers)"
        cell.sectionLabel.text = userProgressArray2[indexPath.row].title.uppercased()

        if let incorrect_answers = userProgressArray2[indexPath.row].incorrect_answers {
            cell.inccorectAnswers.text = "\(incorrect_answers)"
        }
        if let total_time = userProgressArray2[indexPath.row].total_time {
            cell.totalTime.text = "\(Int(truncating: total_time)) second(s)"
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
