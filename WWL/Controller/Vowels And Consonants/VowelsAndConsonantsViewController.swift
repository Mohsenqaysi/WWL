//
//  VowelsAndConsonantsViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 8/4/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit

class VowelsAndConsonantsViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func dissmiss(_ sender: UIButton) {
         self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        self.imageView.center = scrollView.center
        return self.imageView
    }
}
