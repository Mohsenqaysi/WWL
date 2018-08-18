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


struct UserAnswerModel {
    let expectedCounterColor: String!
    let submittedCounterColor: String?
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
    GameModel(key: "01-i_b", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "02-i_D", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "03-E_d", CounterProperty: [CounterProperty(color: 2, counterChanged: true), CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "04-e_P", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "05-e_M", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "06-A_m", CounterProperty: [CounterProperty(color: 2, counterChanged: true), CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "07-a_N", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "08-AR_n", CounterProperty: [CounterProperty(color: 2, counterChanged: true), CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "09-ar_NG", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "10-ar_G", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "11-U_g", CounterProperty: [CounterProperty(color: 2, counterChanged: true), CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "12-u_K", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "13-O_k", CounterProperty: [CounterProperty(color: 2, counterChanged: true), CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "14-o_F", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "15-OR_f", CounterProperty: [CounterProperty(color: 2, counterChanged: true), CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "16-UR_f", CounterProperty: [CounterProperty(color: 2, counterChanged: true), CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "17-ur_V", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "18-ur_TH", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "19-AU_th", CounterProperty: [CounterProperty(color: 2, counterChanged: true), CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "20-au_S", CounterProperty: [CounterProperty(color: 2, counterChanged: false), CounterProperty(color: 1, counterChanged: true)])
]

var Model04: [GameModel] = [
    GameModel(key: "01-m_o_ng", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "02-F_o_ng", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "03-f_OI_ng", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "04_f_oi_S", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "05_D_oi_s", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "06_d_EE_s", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "07-R_ee_s", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "08-r_ee_SH", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "09-r_A_sh", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "10-Z_a_sh", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "11-z_OU_sh", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "12-L_ou_sh", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "13-l_ou_J", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "14-CH_ou_j", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "15-ch_E_j", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "16-K_e_j", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "17-k_e_M", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "18-F_e_m", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "19-f_AU_m", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "20-S_au_m", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 2, counterChanged: true), CounterProperty(color: 1, counterChanged: false)])
]

var Model05: [GameModel] = [
    GameModel(key: "01-p_l__[oo]_", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "02-p_l_OO", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "03-B_l_oo", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "04-b_R_oo", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: true),CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "05-b_r_U", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "07-d_W_u", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: true),CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "08-d_w_O", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "09-S_w_o", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "10-TH_w_o", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "11-th_R_o", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: true),CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "12-th_r_AW", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "13-f_r_aw", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "14-S_l_aw", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "15-s_l_OW", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "16-SH_l_ow", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "17-sh_l_OY", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: true)]),
    GameModel(key: "18-Z_l_oy", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "19-_[Z]__l_oy", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false)]),
    GameModel(key: "20-CH_l_oy", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false)])
]
var Model06: [GameModel] = [
    GameModel(key: "01-s_m_oo_k", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "02-Z_m_oo_k", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "03-z_m__[OO]_k", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: true),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "04-TH_m__[oo]_k", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "05-th_m_E_k", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: true),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "06-F_m_e_k", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "07-f_m_U_k", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: true),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "08-f_m_u_G", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "09-f_N_u_g", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: true),CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "10-V_n_u_g", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "11-v_n_u_NG", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "13-s_R_u_ng", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: true),CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "14-s_r_u_P", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "15-s_r_I_p", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: true),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "16-Z_r_i_p", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "17-z_r_A_p", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: true),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "18-z_r_a_N", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: true)]),
    GameModel(key: "19-L_r_a_n", CounterProperty: [CounterProperty(color: 1, counterChanged: true), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: false)]),
    GameModel(key: "19-L_r_a_n", CounterProperty: [CounterProperty(color: 1, counterChanged: false), CounterProperty(color: 1, counterChanged: false),CounterProperty(color: 2, counterChanged: false),CounterProperty(color: 1, counterChanged: true)])
]

var allLevelsDataArray = [Model02,Model03,Model04,Model05,Model06]


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
