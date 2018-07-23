//
//  Sound.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/23/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import Foundation
import AVFoundation

// AVAudioPlayerDelegate requires NSObjectProtocol
class Sound: NSObject {
    
    var avPlayer: AVAudioPlayer!
    var filename: String!
    
    init(fileName: String) {
        super.init()
        self.filename = fileName
        readFileIntoAVPlayer()
    }
    func stopAVPLayer() {
        if avPlayer.isPlaying {
            avPlayer.stop()
        }
    }
    
    func toggleAVPlayer() {
        print("is playing \(avPlayer.isPlaying)")
        if avPlayer.isPlaying {
            avPlayer.pause()
        } else {
            avPlayer.play()
        }
    }
    
    /**
     Uses AvAudioPlayer to play a sound file.
     The player instance needs to be an instance variable. Otherwise it will disappear before playing.
     */
    func readFileIntoAVPlayer() {
        
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: "mp3") else {
            print("could not read sound file")
            return
        }
        
        do {
            try self.avPlayer = AVAudioPlayer(contentsOf: fileURL)
            //try self.avPlayer = AVAudioPlayer(contentsOfURL: fileURL, fileTypeHint: AVFileTypeMPEGLayer3)
            
        } catch {
            print("could not create AVAudioPlayer \(error)")
            return
        }
        print("playing \(fileURL)")
        avPlayer.delegate = self
        avPlayer.prepareToPlay()
        avPlayer.volume = 1.0
    }
}


// MARK: AVAudioPlayerDelegate
extension Sound: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finished playing \(flag)")
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let e = error {
            print("\(e.localizedDescription)")
        }
    }
}
