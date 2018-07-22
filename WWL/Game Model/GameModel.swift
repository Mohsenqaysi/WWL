//
//  GameModel.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/15/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import Foundation

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

struct GameModel {
    let key: String
    let CounterProperty: [CounterProperty]
}

var Model02: [GameModel] = [
    GameModel(key: "k_a", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "k_u", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "t_u", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "t_ee", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "t_ae", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "l_ae", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "l_ar" , CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "ch_ar", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "ch_oy", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "ch_ow", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "th_ow", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "th_ae", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "r_ae", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "r_i", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "j_i", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "j_au", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "h_au", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "h_ir", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "p_ir", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "b_ir", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)])
]

var allLevelsDataArray = [Model02]

//for (index,v) in allLevelsDataArray[0].enumerated() {
//    let key = v.key
//    let path = "index: \(index)\n Sound-Sequencing.module02/\(v.key).mp3"
//    print("key: \(key)\n \(path)")
//    v.CounterProperty.forEach { (counter) in
//        let colorID = counter.color
//        let color = (counter.color == CounterColor.blueColor.toInt()) ? CounterColor.blueColor : CounterColor.greenColor
//        if counter.counterChanged == true {
//            let counterChanged = counter.counterChanged == true
//            print(" \(colorID) -> \(color) -> \(counterChanged)")
//        }
//    }
//}
