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
import Firebase

protocol UpdatedLevelStatusDelegate {
    func didUpdateIndex(index: Int, flag: Bool)
}

class LevelsViewController: UIViewController,UpdatedLevelStatusDelegate {
   
    func didUpdateIndex(index: Int, flag: Bool) {
        print("didUpdateIndex I was called on updated index ")
        print("index: \(index) - flag: \(flag)")
        levelsStatus[index].flag = flag
        levelCollectionView.reloadData()
    }
    
    var FirebaseNetworkingCallRef = FirebaseNetworkingCall()
    
    var playButton: UIButton! = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let image = #imageLiteral(resourceName: "StartButton")
        button.setImage(image, for: UIControlState.normal)
        return button
    }()
    
    @IBOutlet weak var levelCollectionView: UICollectionView!
    var gameLevelsDataArray: [[GameModel]] = allLevelsDataArray
    var foldernames: [String] = ["module02","module03","module04","module05","module06"]
    
    var levelsStatus = [LevelStatusModel]() {
        didSet {
            print("levelsStatus: \(levelsStatus)")
        }
    }
    
    @IBAction func exitGame(_ sender: UIButton) {
        sender.bounceButtonEffect()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        FirebaseNetworkingCallRef.getlevelsStatus()
//        levelsStatus = FirebaseNetworkingCallRef.getLevelsStatsArry()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        isSoundON(isON: userDefult.bool(forKey: Keys.menuSoundKye.rawValue))
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
            if !levelsStatus.isEmpty {
                let imageNme = levelsStatus[indexPath.item].flag ? "unlock" : "lock"
                cell.imageName = imageNme
                print("levelsStatus index: \(levelsStatus[2])")
            }
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
                        destination.folderName = foldernames[indexPathItem.advanced(by: -1)]
                        destination.testPlayButton = playButton
                        destination.levelIndex = indexPathItem
                        destination.updatedLevelStatusDelegate = self
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)
//        isSoundON(isON: false)
        // Animate selected cell
        selectedCell?.bounceCellEffect()
        if indexPath.item == 0 {
            playVido()
        } else if levelsStatus[indexPath.item].flag {
            performSegue(withIdentifier: Identifiers.presentGameViewSegue, sender: nil)
        } else {
            print("Level is locked for now")
        }
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
