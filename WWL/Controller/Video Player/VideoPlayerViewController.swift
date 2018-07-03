//
//  VideoPlayerViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/3/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerViewController: UIViewController {
    
    let url: String? = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"

    override func viewDidLoad() {
        super.viewDidLoad()
        // guard let videoURL = URL(string: url) else {return}
        if let urlString = url,
            let videoURL = URL(string: urlString){
            let player = AVPlayer(url: videoURL)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            self.view.layer.addSublayer(playerLayer)
            player.play()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

