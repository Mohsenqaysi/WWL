//
//  StopWatchTimer.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/29/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit

class StopWatchTimer: NSObject {

    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    var totalTime: Double!
    func startTimer() {
        if(isPlaying) {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    @objc func UpdateTimer() {
        counter = counter + 0.1
    }
    
    func stopTimer(){
        timer.invalidate()
        totalTime = counter
        isPlaying = false
    }
    func getTimer() -> Double {
        return totalTime
    }
}
