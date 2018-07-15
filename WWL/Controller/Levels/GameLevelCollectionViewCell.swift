//
//  GameLevelCollectionViewCell.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/2/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit

class GameLevelCollectionViewCell: UICollectionViewCell {
    var imageName: String! {
        didSet {
            imageView.image = UIImage(named: imageName)
        }
    }
    var levelText: String! {
        didSet {
            levelLabel.text = levelText
        }
    }
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var levelLabel: UILabel!
}
