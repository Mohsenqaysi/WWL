//
//  UserProfileViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/29/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var userProgressArray: [String] = ["hi"]
    
    @IBOutlet weak var userNmaelabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var noDataImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if userProgressArray.isEmpty {
            self.noDataImage.isHidden = false
        }
        
        self.userNmaelabel.text = "Mohsen Qaysi"
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UserProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProgressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.profileCellID, for: indexPath)
        cell.textLabel?.text = userProgressArray[indexPath.row]
        cell.imageView?.image = #imageLiteral(resourceName: "profile")
        return cell
    }
}
