//
//  Sound.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/23/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

// AVAudioPlayerDelegate requires NSObjectProtocol
class Sound: NSObject {

    lazy var gameController = GameViewController()
    
    var avPlayer: AVAudioPlayer!
    var filename: String!
    var withExtension: String!
    var isFinishedPlaying: Bool! = false
    var playingButton: UIButton!
    var index: Int!
    var folderName: String!
    var startingCounter: String!
    var filePath: String!
    var didPlayStartingCounters = false

    
    init(folderName: String, fileName: String, fileIndex: Int, startingCounter: String = "", withExtension: String = "mp3") {
        super.init()
        self.folderName = folderName
        self.filename = fileName
        self.index = fileIndex
        self.startingCounter = startingCounter
        self.withExtension = withExtension
        readFile()
    }
    fileprivate func readFile(){
        let path = "\(folderName!)/\(filename!)"
        print("path: \(path)")
        readFileIntoAVPlayer(path: path)
    }
    
    /**
     Uses AvAudioPlayer to play a sound file.
     The player instance needs to be an instance variable. Otherwise it will disappear before playing.
     */
    func readFileIntoAVPlayer(path: String) {
        guard let fileURL = Bundle.main.url(forResource: path, withExtension: withExtension) else {
            print("could not read sound file")
            return
        }
        
        do {
            try self.avPlayer = AVAudioPlayer(contentsOf: fileURL)
        } catch {
            print("could not create AVAudioPlayer \(error)")
            return
        }
        print("playing \(fileURL)")
        avPlayer.delegate = self
        avPlayer.prepareToPlay()
        avPlayer.volume = 1.0
    }
    
    func stopSoundTrack() {
        if avPlayer.isPlaying {
            avPlayer.stop()
        }
    }
    
    func playSoundTrack(sender: UIButton?, completion: (()->())?)  {
        if sender != nil {
            self.playingButton = sender
            if playingButton.alpha == 0.0 {
                playingButton.isEnabled = false
            } else {
                playingButton.alpha = 0.5
                playingButton.isEnabled = false
            }
        }
//        print("is playing \(avPlayer.isPlaying)")
        if avPlayer.isPlaying {
            avPlayer.pause()
        } else {
            avPlayer.play()
        }
        completion?()
    }

}
// MARK: AVAudioPlayerDelegate
extension Sound: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        gameController.didFinishedPalying(successfully: flag)
        if flag {
            if index == 0 && !didPlayStartingCounters {
                didPlayStartingCounters = true
                let path = "\(folderName!)/\(startingCounter!)"
                print("startingFilePath is: \(path)")
                readFileIntoAVPlayer(path: path)
                playSoundTrack(sender: nil, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    if self.playingButton != nil && self.playingButton.alpha == 0.0 {
                        self.playingButton.alpha = 1.0
                        self.playingButton.isEnabled = true
                    }
                }
            } else if playingButton != nil {
                playingButton.alpha = 1.0
                playingButton.isEnabled = true
            }
        }
        
//        if playingButton != nil && didPlayStartingCounters {

//        }
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let e = error {
            print("\(e.localizedDescription)")
        }
    }
}
