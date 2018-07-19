//
//  GameModel.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/15/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import Foundation

struct Game {
    let key: String
    let blue: Int
    let green: Int
    let counterChanged: Int?
}
enum CounterColor: Int {
    case blue = 1
    case green = 2
    func toInt() -> Int {
        return self.rawValue
    }
}

let moduleTwoArrayAnswers: [Game] = [
    Game(key: "k_a", blue: 1, green: 2, counterChanged: nil),
    Game(key: "k_u", blue: 1, green: 2, counterChanged: 2),
    Game(key: "t_u", blue: 1, green: 2, counterChanged: 1),
    Game(key: "t_ee", blue: 1, green: 2, counterChanged: 2),
    Game(key: "t_ae", blue: 1, green: 2, counterChanged: 2),
    Game(key: "l_ae", blue: 1, green: 2, counterChanged: 1),
    Game(key: "l_ar", blue: 1, green: 2, counterChanged: 2),
    Game(key: "ch_ar", blue: 1, green: 2, counterChanged: 1),
    Game(key: "ch_oy", blue: 1, green: 2, counterChanged: 2),
    Game(key: "ch_ow", blue: 1, green: 2, counterChanged: 2),
    Game(key: "th_ow", blue: 1, green: 2, counterChanged: 1),
    Game(key: "th_ae", blue: 1, green: 2, counterChanged: 2),
    Game(key: "r_ae", blue: 1, green: 2, counterChanged: 1),
    Game(key: "r_i", blue: 1, green: 2, counterChanged: 2),
    Game(key: "j_i", blue: 1, green: 2, counterChanged: 1),
    Game(key: "j_au", blue: 1, green: 2, counterChanged: 2),
    Game(key: "h_au", blue: 1, green: 2, counterChanged: 1),
    Game(key: "h_ir", blue: 1, green: 2, counterChanged: 2),
    Game(key: "p_ir", blue: 1, green: 2, counterChanged: 1),
    Game(key: "b_ir", blue: 1, green: 2, counterChanged: 1)
]

var moduleTwoUserAnsers: [Game] = [
    Game(key: "k_u", blue: 1, green: 2, counterChanged: 2),
    Game(key: "t_u", blue: 1, green: 2, counterChanged: 1),
    Game(key: "t_ee", blue: 1, green: 2, counterChanged: 2),
    Game(key: "t_ae", blue: 1, green: 2, counterChanged: 2),
    Game(key: "l_ae", blue: 1, green: 2, counterChanged: 1),
    Game(key: "l_ar", blue: 1, green: 2, counterChanged: 2),
    Game(key: "ch_ar", blue: 1, green: 2, counterChanged: 1),
    Game(key: "ch_oy", blue: 1, green: 2, counterChanged: 2),
    Game(key: "ch_ow", blue: 1, green: 2, counterChanged: 2),
    Game(key: "th_ow", blue: 1, green: 2, counterChanged: 1),
    Game(key: "th_ae", blue: 1, green: 2, counterChanged: 2),
    Game(key: "r_ae", blue: 1, green: 2, counterChanged: 1),
    Game(key: "r_i", blue: 1, green: 2, counterChanged: 2),
    Game(key: "j_i", blue: 1, green: 2, counterChanged: 1),
    Game(key: "j_au", blue: 1, green: 2, counterChanged: 2),
    Game(key: "h_au", blue: 1, green: 2, counterChanged: 1),
    Game(key: "h_ir", blue: 1, green: 2, counterChanged: 2),
    Game(key: "p_ir", blue: 1, green: 2, counterChanged: 1),
    Game(key: "b_ir", blue: 1, green: 2, counterChanged: 1)
]

//// MARK:- Increment the index manually
//print("*_______________*")
//for index in 1..<moduleTwoArrayAnswers.count {
//    if let counterChanged = moduleTwoArrayAnswers[index].counterChanged {
//        let counterDidNotChanged = counterChanged == 1 ? 2 : 1
//        let changedColor = (counterChanged == CounterColor.blue.toInt()) ? CounterColor.blue : CounterColor.green
//        let didNotchangedColor = (counterDidNotChanged == CounterColor.blue.toInt()) ? CounterColor.blue : CounterColor.green
//        //        print("|\(changedColor)  |  \(didNotchangedColor)|")
//        print("counterChanged: \(counterChanged) -> \(changedColor)")
//        print("\(counterDidNotChanged) -> \(didNotchangedColor) is locked")
//        print("--------------------------")
//    }
//}
//print("*_______________*")



//moduleTwoArrayAnswers.index(after: 1)
//for value in moduleTwoArrayAnswers.index(after: 1) {
//    print(value)
//    // for j in 0...moduleTwoUserAnsers.count {
//    //     // print(moduleTwoArrayAnswers[i])
//    //     // print(moduleTwoUserAnsers[j])
//    //       print("\(i) - \(j)")
//
//    // }
//    //statements of outerloop
//}

// for userAnsers in moduleTwoArrayAnswers {
//     print(userAnsers)
// }

// for soundSequence in moduleTwoArrayAnswers {
//    if soundSequence.counterChanged != nil {
//        // print("Sound-Sequencing.module02/\(soundSequence.key).mp3")
//        if let counterChanged = soundSequence.counterChanged {
//            let changedColor = (counterChanged == CounterColor.blue.toInt()) ? CounterColor.blue : CounterColor.green
//        print("\(counterChanged) -> \(changedColor)  ")
//        }
//    }
// }
