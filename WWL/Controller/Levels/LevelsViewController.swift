//
//  LevelsViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/2/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

private let reuseIdentifier = "Cell"
let url: String? = "https://firebasestorage.googleapis.com/v0/b/wordsworth-learning.appspot.com/o/Introduction%20Video%2Flevel2_sound_sequencing_new3.mp4?alt=media&token=b1d1e032-4008-465b-811b-eb47653aa022"

class LevelsViewController: UIViewController {
    
    @IBAction func exitGame(_ sender: UIButton) {
        sender.bounceButtonEffect()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isSoundON(isON: userDefult.bool(forKey: Keys.menuSoundKye.rawValue))
        print("viewWillAppear was called")
    }
    
}

extension LevelsViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GameLevelCollectionViewCell
            videoCell.loadingCellAnimation()
            videoCell.imageView.image = UIImage(named: "video_icon")
            videoCell.levelLabel.text = "Intruduction Video"
            return videoCell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GameLevelCollectionViewCell
            cell.loadingCellAnimation()
            cell.levelLabel.text = "Module \(indexPath.item)"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)
        isSoundON(isON: false)
        // Animate selected cell
        selectedCell?.bounceCellEffect()
        if indexPath.item == 0 {
            playVido()
        }
    }
    fileprivate func playVido() {
        let avPlayerController = AVPlayerViewController()
        avPlayerController.entersFullScreenWhenPlaybackBegins = true
        avPlayerController.allowsPictureInPicturePlayback = false
        
        if let urlString = url,
            let videoURL = URL(string: urlString){
            let avPlayer = AVPlayer(url: videoURL)
            avPlayerController.player = avPlayer
            present(avPlayerController, animated: true, completion: {
                avPlayer.play()
            })
        }
    }
}

