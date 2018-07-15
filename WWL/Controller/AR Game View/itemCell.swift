//
//  itemCell.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/14/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit

class itemCell: UICollectionViewCell {
    
    var imageName: String! {
        didSet{
            counterImageView.image = UIImage(named: imageName)
        }
    }
    @IBOutlet weak var counterImageView: UIImageView!
}
