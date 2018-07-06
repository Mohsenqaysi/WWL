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
struct FirebaseNetworkingCall {
    var levelsArray = [Dictionary<String, Bool>]()
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
    }
    
    mutating func saveUserSignUpData(withUserName username: String, email: String, uid: String) {
        self.ref.child("users").child(uid).setValue(["username": username, "email": email])
        modulesAccess(uid: uid)
    }
    
    fileprivate mutating func modulesAccess(uid: String){
        let dic: Dictionary<String, Bool>
        dic = ["0" : false, "1" : true, "2" : true, "3" : true, "4" : true, "5" : true, "6" : true]
        self.ref.child("levels_status").child(uid).setValue(dic)
    }
}

