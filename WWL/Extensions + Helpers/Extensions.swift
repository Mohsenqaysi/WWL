//
//  Extensions.swift
//  WWL
//
//  Created by Mohsen Qaysi on 6/26/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import Foundation
import UIKit

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

let PinkColor = UIColor(red:0.76, green:0.18, blue:0.48, alpha:1.0)
let blueColor = UIColor(red:0.35, green:0.66, blue:0.89, alpha:1.0)
