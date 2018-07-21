//
//  MyAudioPlayer.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/1/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//
// COPYRIGHT: https://stackoverflow.com/questions/34435387/how-to-implement-avaudioplayer-inside-singleton-method

import Foundation
import AVFoundation
var player: AVAudioPlayer?

class MyAudioPlayer: NSObject, AVAudioPlayerDelegate {
    private static let sharedPlayer: MyAudioPlayer = {
        return MyAudioPlayer()
    }()
    
    private var container = [String : AVAudioPlayer]()
    
    static func playFile(name: String, type: String) {
        let key = name+type
        for (file, thePlayer) in sharedPlayer.container {
            if file == key {
                player = thePlayer
                break
            }
        }
        if player == nil, let resource = Bundle.main.path(forResource: name, ofType:type) {
            let soundPath = URL(fileURLWithPath: resource)
            do {
                player = try AVAudioPlayer(contentsOf: soundPath, fileTypeHint: "MP3")
            } catch {
            }
        }
        if let thePlayer = player {
            if thePlayer.isPlaying {
                // already playing
            } else {
                thePlayer.delegate = sharedPlayer
                sharedPlayer.container[key] = thePlayer
                thePlayer.play()
            }
        }
    }
    
    static func stopSound(){
        player?.stop()
    }
}
