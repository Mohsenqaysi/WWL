//
//  SoundPlayer.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/23/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit
import AVFoundation

class SoundPlayer: NSObject,AVAudioPlayerDelegate {
    
    var avPlayer: AVAudioPlayer!
    var filePath: String!
    required init(fileName: String) {
        super.init()
        print("filePath: \(fileName)")
        self.filePath = fileName
        readFileIntoAVPlayer()
    }
    
    func readFileIntoAVPlayer() {
        guard let fileURL = Bundle.main.url(forResource: filePath, withExtension: "mp3") else {
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
    
    func playSound(){
        do {
//            player = try AVAudioPlayer(contentsOf: url)
            avPlayer.play()
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
}
