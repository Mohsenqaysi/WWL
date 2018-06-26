//
//  Extensions.swift
//  WWL
//
//  Created by Mohsen Qaysi on 6/26/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func setTitleAndColor(for nav: UINavigationController, itme: UINavigationItem, title: String, color: UIColor){
        // Chnage the navigation Bar Tint Color and title
        nav.navigationBar.tintColor = color
        let attributes = [NSAttributedStringKey.foregroundColor: color]
        nav.navigationBar.titleTextAttributes = attributes
        itme.title = title
    }
}
