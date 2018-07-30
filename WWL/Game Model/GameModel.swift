//
//  GameModel.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/15/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import Foundation

struct LevelStatusModel {
    var key: Int
    var flag: Bool
}
struct LevelProgress {
    var section: String
    var incorrect_answers: NSNumber
    var total_time: NSNumber
}
//  [String : Double]
// ["incorrect_answers": 0.0, "total_time": 12.99999999999997]
struct UserProgressModel {
    var levelKey: String
    var LevelAnsers: [[String : Double]]
}

enum CounterColor: Int {
    case blueColor = 1
    case greenColor = 2
    func toInt() -> Int {
        return self.rawValue
    }
}

struct CounterProperty {
    let color: Int
    let counterChanged: Bool
}

struct UserAnswerModel {
    let expectedCounterColor: String!
    let submittedCounterColor: String?
}

struct GameModel {
    let key: String!
    let CounterProperty: [CounterProperty]
}

var Model02: [GameModel] = [
    GameModel(key: "k_a", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "k_u", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "t_u", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "t_ee", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "t_ae", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "L_ae", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "L_ar" , CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "ch_ar", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "ch_oy", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "ch_ow", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "TH_ow", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "th_ae", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "r_ae", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "r_i", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "J_i", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "j_au", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "h_au", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "h_ir", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "p_ir", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "b_ir", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)])
]

var Model03: [GameModel] = [
    GameModel(key: "01-i_b", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "k_u", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "t_u", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "t_ee", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "t_ae", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "l_ae", CounterProperty: [CounterProperty(color: 2, counterChanged: true),CounterProperty(color: 2, counterChanged: true), CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "l_ar" , CounterProperty: [CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: true),CounterProperty(color: 2, counterChanged: true), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "ch_ar", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "ch_oy", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "ch_ow", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "TH_ow", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "th_ae", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "r_ae", CounterProperty: [CounterProperty(color: 2, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "r_i", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "j_i", CounterProperty: [CounterProperty(color: 2, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "j_au", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "h_au", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "h_ir", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "p_ir", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "b_ir", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)])
]

var allLevelsDataArray = [Model02,Model03]


//func checkAnswers() {
//    // MARK:- Increment the index manually
//    print("*_______________*")
//    // This one will allow me to model all 6 models coz some will have upto 4 counters with different colors
//    for (index,value) in gameLevelsDataArray[0].enumerated() {
//        let key = value.key
//        let path = "index: \(index)\n Sound-Sequencing.module02/\(value.key).mp3"
//        print("key: \(String(describing: key))\n \(path)")
//        // Loop over all innder counters
//        value.CounterProperty.forEach { (counter) in
//            let colorID = counter.color
//            let color = (counter.color == CounterColor.blueColor.toInt()) ? CounterColor.blueColor : CounterColor.greenColor
//            if counter.counterChanged {
//                let counterChanged = counter.counterChanged == true
//                print(" \(colorID) -> \(color) -> \(counterChanged)")
//            }
//        }
//    }
//    print("*_______________*")
//}
