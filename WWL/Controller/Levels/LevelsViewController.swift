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


class LevelsViewController: UIViewController {
    
    @IBAction func exitGame(_ sender: UIButton) {
        sender.bounceButtonEffect()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAnswers()
    }
    func checkAnswers() {
        // MARK:- Increment the index manually
        print("*_______________*")
        // This one will allow me to model all 6 models coz some will have upto 4 counters with different colors
        for (index,v) in testCounterProperty.enumerated() {
            v.forEach {
                if index != 0 {
                    let key = $0.key
                    let path = "index: \(index)\n Sound-Sequencing.module02/\($0.key).mp3"
                    print("key: \(key)\n \(path)")
                    for vlaues in $0.value.enumerated() {
                        let colorID = vlaues.element.color
                        let color = (vlaues.element.color == CounterColor.blueColor.toInt()) ? CounterColor.blueColor : CounterColor.greenColor
                        if  vlaues.element.counterChanged == true {
                            let counterChanged = vlaues.element.counterChanged == true
                            print(" \(colorID) -> \(color) -> \(counterChanged)")
                        }
                    }
                }
            }
        }
        print("*_______________*")
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
            let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.LevelsViewControllerCell, for: indexPath) as! GameLevelCollectionViewCell
            videoCell.loadingCellAnimation()
            videoCell.imageName = "video_icon"
            videoCell.levelText = "Intruduction Video"
            return videoCell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.LevelsViewControllerCell, for: indexPath) as! GameLevelCollectionViewCell
            cell.loadingCellAnimation()
            cell.levelText = "Module \(indexPath.item)"
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
        performSegue(withIdentifier: Identifiers.presentGameViewSegue, sender: nil)
    }
    
    fileprivate func playVido() {
        let avPlayerController = AVPlayerViewController()
        avPlayerController.entersFullScreenWhenPlaybackBegins = true
        avPlayerController.allowsPictureInPicturePlayback = false
        
        if let urlString = intorductionVideoURL,
            let videoURL = URL(string: urlString){
            let avPlayer = AVPlayer(url: videoURL)
            avPlayerController.player = avPlayer
            present(avPlayerController, animated: true, completion: {
                avPlayer.play()
            })
        }
    }
}

