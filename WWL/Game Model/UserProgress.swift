//
//  UserProgress.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/30/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit

class UserProgress: NSObject {
    var title: String!
    var incorrect_answers: NSNumber!
    var total_time: NSNumber!
    
    init(title: String, dictionary: [String: AnyObject]) {
        super.init()
        self.title = title
        self.incorrect_answers = dictionary["incorrect_answers"] as! NSNumber
        self.total_time = dictionary["total_time"] as! NSNumber
    }
}
