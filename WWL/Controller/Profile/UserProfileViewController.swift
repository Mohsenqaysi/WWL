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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    func getlevelsProgress() {
        userProgressArray.removeAll()
        let userID = FirebaseNetworkingCallRef.getUserID()
        var valueList = [NSNumber]()
        var sectionKey: String!
        self.ref.child(FirebasePaths.user_progress.toString()).child(userID).observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                sectionKey = snapshot.key
                print("dictionary count: \(dictionary.count)")
                for each in dictionary.values {
                    valueList.append(each as! NSNumber)
                    //                    let incorrect_answers = each.value["incorrect_answers"]
                    //                    let total_time = each.value["total_time"]
                    //                    print(incorrect_answers)
                    //                    print(total_time)
                }
                print(valueList[0])
                print(valueList[1])
                self.userProgressArray.append(LevelProgress(section: sectionKey, incorrect_answers: valueList[0], total_time: valueList[1]))
                DispatchQueue.main.async {
                    self.profileTbaleView.reloadData()
                }
            }
        })
    }
    
        
//        self.ref.child(FirebasePaths.user_progress.toString()).child(userID).observe(.childAdded, with: { (snapshot) in
//            if let dictionary = snapshot.value as? [String : AnyObject] {
//                print("dictionary: \(dictionary.count)")
//                print("dictionary: \(dictionary)")
//                let key = snapshot.key
//                let userProgress = UserProgress(title: key, dictionary: dictionary)
//                self.userProgressArray.append(userProgress)
//

//            }
//        }, withCancel: nil)
//    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UserProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(" numberOfRowsInSection: \(userProgressArray.count)")
        return userProgressArray.count
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        print("numberOfSections: \(userProgressArray.count)")
//        return userProgressArray.count
//    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return userProgressArray[section]
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.profileCellID, for: indexPath) as! ProfileCell
        
//        if let _ = userProgressArray[indexPath.row],
//           if let total_time = userProgressArray[indexPath.row].total_time,
//            let incorrect_answers = userProgressArray[indexPath.row].incorrect_answers {
//            cell.inccorectAnswers.text = "\(incorrect_answers)"
//            let time = Double().NSNumberFormater(Double(exactly: total_time)!)
//            cell.totalTime.text = "\(time) Mins:Sec"
        //        }
        
        let total_time = userProgressArray[indexPath.row].total_time
        let time = Double().NSNumberFormater(Double(exactly: total_time)!)
        let incorrect_answers = userProgressArray[indexPath.row].incorrect_answers
        cell.sectionLabel.text =  userProgressArray[indexPath.row].section
        cell.totalTime.text = time//"\(total_time)"
        cell.inccorectAnswers.text = "\(incorrect_answers)"
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
