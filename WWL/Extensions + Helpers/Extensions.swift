//
//  Extensions.swift
//  WWL
//
//  Created by Mohsen Qaysi on 6/26/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import Foundation
import UIKit
import Firebase

// Chnage the navigation Bar Tint Color and title
extension UINavigationController {
    func setTitleAndColor(for nav: UINavigationController, itme: UINavigationItem, title: String, color: UIColor){
        nav.navigationBar.tintColor = color
        let attributes = [NSAttributedStringKey.foregroundColor: color]
        nav.navigationBar.titleTextAttributes = attributes
        itme.title = title
    }
}

// Show alert messages
extension UIAlertController {
    func alertMessages(title: String, message: String ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
}

// Alerts Messages 
struct AlertsMessages {
    static let Successful = "Successful"
    static let successfulMessage = "You have been registered to the system 😃 successfully"
    static let successfulResetMessage = "An email has being sent to you 😃 successfully"
    static let Error = "Error..."
    static let requiredFiled = "This filed is required"
    static let passwordLength = "The password must be 6 characters long or more."
    static let emilIsUsed = "The email address is already in use by another account."
    static let emilBadFormt = "The email address is badly formatted."
}

// Identifiers IDs
struct Identifiers {
    static let LoginViewController = "LoginViewControllerID"
    static let ViewController = "ViewController"
    static let AuthViewControllerScene = "AuthViewControllerScene"
    static let MainViewController = "MainViewController"
    static let AlreadyLoggedIn = "AlreadyLoggedIn"
    static let LoggedOut = "LoggedOut"
    static let CellID = "CellID"

}

enum Keys: String {
    case menuSoundKye = "MenuSoundKye"
    case isLoggedIn = "IsLoggedIn"
}

// Text Field is empty - show red border
func errorHighlightTextField(textField: UITextField){
    textField.layer.borderColor = UIColor.red.cgColor
    textField.layer.borderWidth = 1
    textField.layer.cornerRadius = 5
}

// Text Field is NOT empty - show gray border with 0 border width
func removeErrorHighlightTextField(textField: UITextField){
    textField.layer.borderColor = UIColor.gray.cgColor
    textField.layer.borderWidth = 0
    textField.layer.cornerRadius = 5
}

func isSoundON(isON: Bool){
    if isON {
        DispatchQueue.main.async {
            MyAudioPlayer.playFile(name: "puzzleGameLooping", type: "mp3")
        }
    } else {
        DispatchQueue.main.async {
            MyAudioPlayer.stopSound()
        }
    }
}
extension UIButton {
    func bounceButtonEffect() {
        //MARK: make the button half its original size
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [weak self] in
            self?.transform = .identity
            self?.tintColor = self?.tintColor == UIColor.red ? UIColor.darkGray : UIColor.red
            }, completion: nil)
    }
}

let PinkColor = UIColor(red:0.76, green:0.18, blue:0.48, alpha:1.0)
let blueColor = UIColor(red:0.35, green:0.66, blue:0.89, alpha:1.0)
