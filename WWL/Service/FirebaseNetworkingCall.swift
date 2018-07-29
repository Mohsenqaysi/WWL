//
//  FirebaseNetworkingCall.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/6/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import Firebase
import FirebaseDatabase
import FirebaseAuth

struct Levels {
    let index: String
    let is_open: Bool
}

enum FirebasePaths: String {
    case users = "users"
    case levels_status = "levels_status"
    case user_progress = "user_progress"
    func toString() -> String {
        return self.rawValue
    }
}


struct FirebaseNetworkingCall {
    fileprivate var levelsArray = [Dictionary<String, Bool>]()
    
    var ref: DatabaseReference!
    init() {
        ref = Database.database().reference()
    }
    
    func saveUserSignUpData(withUserName username: String, email: String, uid: String) {
        let dic = ["username": username, "email": email]
        self.ref.child(FirebasePaths.users.rawValue).child(uid).setValue(dic)
        modulesAccess(uid: uid)
    }
    
    // user_progress/gF6HZq7d9GbBwYJpUklslSupn642/module02
    func getUserID() -> String {
        guard let userID = Auth.auth().currentUser?.uid, Auth.auth().currentUser?.uid != nil else {
            fatalError("No User exsists")
        }
        return userID
    }
    mutating func saveUserProgres(modle: String, time: Double, inconrrectAnswers: Int) {
        let dic: [String : Double]
        dic = ["incorrect_answers" : Double(inconrrectAnswers), "total_time" : time]
        self.ref.child(FirebasePaths.user_progress.toString()).child(getUserID()).child(modle).setValue(dic)
    }
    
    func updateNextLevelsStatus(_ levelIndex: Int) {
        var dic: [String : Bool]
        dic = ["\(levelIndex)": true]
        self.ref.child(FirebasePaths.levels_status.toString()).child(getUserID()).updateChildValues(dic)
        
    }
    
    fileprivate func modulesAccess(uid: String){
        let dic: Dictionary<String, Bool>
        dic = ["0" : true, "1" : true, "2" : false, "3" : false, "4" : false, "5" : false, "6" : false]
        self.ref.child(FirebasePaths.levels_status.toString()).child(uid).setValue(dic)
    }
    
}

