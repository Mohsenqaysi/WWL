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
}
struct FirebaseNetworkingCall {
    fileprivate var levelsArray = [Dictionary<String, Bool>]()
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
    }
    
     func saveUserSignUpData(withUserName username: String, email: String, uid: String) {
        self.ref.child(FirebasePaths.users.rawValue).child(uid).setValue(["username": username, "email": email])
        modulesAccess(uid: uid)
    }
    
    fileprivate func modulesAccess(uid: String){
        let dic: Dictionary<String, Bool>
        dic = ["0" : false, "1" : true, "2" : true, "3" : true, "4" : true, "5" : true, "6" : true]
        self.ref.child(FirebasePaths.levels_status.rawValue).child(uid).setValue(dic)
    }
    
}

