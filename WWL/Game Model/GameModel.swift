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

// I like this one the most
var testCounterProperty: [[String : [CounterProperty]]] = [
    ["k_a" : [CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false)]],
    ["k_u" : [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]],
    ["t_u" : [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]],
    ["t_ee" : [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]],
    ["t_ae" : [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]],
    ["l_ae" : [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]],
    ["l_ar" : [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]],
    ["ch_ar" : [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]],
    ["ch_oy" : [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]],
    ["ch_ow" : [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]],
    ["th_ow" : [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]],
    ["th_ae" : [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]],
    ["r_ae" : [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]],
    ["r_i" : [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]],
    ["j_i" : [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]],
    ["j_au" : [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]],
    ["h_au" : [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]],
    ["h_ir" : [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true)]],
    ["p_ir" : [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]],
    ["b_ir" : [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false)]]
]

//// This one will allow me to model all 6 models coz some will have upto 4 counters with different colors
//for (index,v) in testCounterProperty.enumerated() {
//    v.forEach {
//        if index != 0 {
//            let key = $0.key
//            let path = "index: \(index)\n Sound-Sequencing.module02/\($0.key).mp3"
//            print("key: \(key)\n \(path)")
//            for vlaues in $0.value.enumerated() {
//                let colorID = vlaues.element.color
//                let color = (vlaues.element.color == CounterColor.blueColor.toInt()) ? CounterColor.blueColor : CounterColor.greenColor
//                if  vlaues.element.counterChanged == true {
//                    let counterChanged = vlaues.element.counterChanged == true
//                    print(" \(colorID) -> \(color) -> \(counterChanged)")
//                }
//            }
//        }
//    }
//}
