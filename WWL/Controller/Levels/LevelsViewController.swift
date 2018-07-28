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
    
       var playButton: UIButton! = {
            var button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            let image = #imageLiteral(resourceName: "StartButton")
            button.setImage(image, for: UIControlState.normal)
            return button
        }()

    @IBOutlet weak var levelCollectionView: UICollectionView!
    var gameLevelsDataArray: [[GameModel]] = allLevelsDataArray
    var foldernames: [String] = ["module02","module03","module04","module05","module06"]

    @IBAction func exitGame(_ sender: UIButton) {
        sender.bounceButtonEffect()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        checkAnswers()
    }
    
    func checkAnswers() {
        // MARK:- Increment the index manually
        print("*_______________*")
        // This one will allow me to model all 6 models coz some will have upto 4 counters with different colors
        for (index,value) in gameLevelsDataArray[0].enumerated() {
            let key = value.key
            let path = "index: \(index)\n Sound-Sequencing.module02/\(value.key).mp3"
            print("key: \(String(describing: key))\n \(path)")
            // Loop over all innder counters
            value.CounterProperty.forEach { (counter) in
                let colorID = counter.color
                let color = (counter.color == CounterColor.blueColor.toInt()) ? CounterColor.blueColor : CounterColor.greenColor
                if counter.counterChanged {
                    let counterChanged = counter.counterChanged == true
                    print(" \(colorID) -> \(color) -> \(counterChanged)")
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
        // The first cell contians the introduction Video
        return gameLevelsDataArray.count.advanced(by: 1)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // pass the Model data to the GameView
        if segue.identifier == Identifiers.presentGameViewSegue {
            if let destination = segue.destination as? GameViewController {
                if let indexPathItem = levelCollectionView.indexPathsForSelectedItems?.first?.item {
                    print("\(indexPathItem)")
                    if indexPathItem != 0 {
                        
                        // The selected cell is one ... but the array starts at zero, so we take one away
                        let selectedData = gameLevelsDataArray[indexPathItem.advanced(by: -1)]
                        destination.levelDataArray = selectedData
                        destination.foldername = foldernames[indexPathItem.advanced(by: -1)]
                        
                        destination.testPlayButton = playButton
                    }
                }
            }
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

