//
//  LevelsViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/2/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"

class LevelsViewController: UIViewController {
    
    @IBAction func exitGame(_ sender: UIButton) {
        sender.bounceButtonEffect()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}


extension LevelsViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        
        return cell
    }
}
