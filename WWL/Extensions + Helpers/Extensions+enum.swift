//
//  Extensions+enum.swift
//  WWL
//
//  Created by Mohsen Qaysi on 6/26/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import Foundation
import UIKit
import ARKit
import Firebase
import AudioToolbox

let userDefult = UserDefaults.standard
let intorductionVideoURL: String! = "https://firebasestorage.googleapis.com/v0/b/wordsworth-learning.appspot.com/o/Introduction%20Video%2Flevel2_sound_sequencing_new3.mp4?alt=media&token=b1d1e032-4008-465b-811b-eb47653aa022"

enum GuesturesIDs: Int {
    case tap = 1
    case pan = 2
    case longPress = 3
    func toInt() -> Int {
        return self.rawValue
    }
}

enum BoxBodyType: Int {
    case bullet = 1
    case barrier = 2
    func toInt() -> Int {
        return self.rawValue
    }
}

enum BoxBodyTypeName : String {
    case counter
    case barrier
    func toString() -> String {
        return self.rawValue
    }
}
// MARK: - StaticNodes
enum StaticNodes: String {
    case farmPlanefinal
    case counterBaseOneNode
    case counterBaseTwoNode
    case counterBaseThreeNode
    case counterBaseFourNode
    func toString() -> String {
        return self.rawValue
    }
}
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
    static let CongratulationFinishedLevel = "Congratulation you have completed the level 😃"

}

// Identifiers IDs
struct Identifiers {
    static let LoginViewController = "LoginViewControllerID"
    static let ViewController = "ViewController"
    static let AuthViewControllerScene = "AuthViewControllerScene"
    static let MainViewController = "MainViewController"
    static let AlreadyLoggedIn = "AlreadyLoggedIn"
    static let LoggedOut = "LoggedOut"
    static let presentGameViewSegue = "presentGameViewSegue"
    static let CellID = "CellID"
    static let LevelsViewControllerCell = "LevelsViewControllerCell"
    static let itemID = "item"
    static let profileCellID = "profileCellID"
    // Nodes IDs
    static let blueCounter = "blueCounter"
    static let greenCounter = "greenCounter"
    
    // Counters Names
    static let blueCounterNodeOne = "blueCounterNodeOne"
    static let blueCounterNodeTwo = "blueCounterNodeTwo"
    static let blueCounterNodeThree = "blueCounterNodeThree"
    static let greenCounterNodeOne = "greenCounterNodeOne"
}



enum Keys: String {
    case menuSoundKye = "MenuSoundKye"
    case isLoggedIn = "IsLoggedIn"
    case reminderTimeKey = "reminderTimeKey"
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
            MyAudioPlayer.playFile(name: "menu", type: "mp3")
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
            }, completion: nil)
    }
    func blinkingButtonEffect(duration: TimeInterval = 0.4) {
        self.alpha = 0
        UIView.animate(withDuration: duration, delay: 0, options: [.repeat, .curveEaseInOut], animations: {
            UIView.setAnimationRepeatCount(3)
            self.alpha = 1
        }, completion: nil)
    }
}

extension UIView {
    // completion: ((Bool) -> Swift.Void)? = nil)
    func bounceCellEffect() {
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [weak self] in
            self?.transform = .identity
            },completion: nil)
    }
    
    func loadingCellAnimation() {
        self.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseInOut, animations: {
            self.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        }
    }
    
    func statusShowLabelAnimation(isHidden: Bool) {
        self.isHidden = isHidden
        self.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        }
    }
    func statusHideLabelAnimation(isHidden: Bool) {
        self.layer.transform = CATransform3DMakeScale(1,1,1)
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        }) { (complete) in
            self.isHidden = isHidden
        }
    }
}

extension UIToolbar {
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }
}

enum CamerStatus: String {
    case normal = "The light is normal"
    case limited = "The light in your enviroment is limited ... please find a better lighted place"
    case NotAvailable = "Not Available ... please find a better lighted place"
    func toString()-> String {
        return self.rawValue
    }
}


struct UIExtendedSRGBColorSpaceToUIColor: Hashable {
    static let green = ["Optional(UIExtendedSRGBColorSpace 0.197085 0.571505 0.156546 1)" : "greenColor" ]
    static let blue = ["Optional(UIExtendedSRGBColorSpace 0.0395691 0.337999 0.71286 1)": "blueColor"]
}

extension SCNNode {
    // MARK: set up aniamtion
    
    func addFloatingAnimationToNode(node: SCNNode, x: CGFloat = 0, y: CGFloat = 0.03, z: CGFloat = 0, duration: TimeInterval = 1.5 ) {
        //        let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 5.0)
        let hoverUp = SCNAction.moveBy(x: x, y: y, z: z, duration: duration)
        let hoverDown = SCNAction.moveBy(x: x, y: -y, z: z, duration: duration)
        let hoverSequence = SCNAction.sequence([hoverUp, hoverDown])
        //        let rotateAndHover = SCNAction.group([hoverSequence])
        let repeatForever = SCNAction.repeatForever(hoverSequence)
        node.runAction(repeatForever)
    }
    
    func addShakingAnimationToNode(ShakingDistants: Float, complete: (() -> Void)) {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        let spin = CABasicAnimation(keyPath: "position")
        spin.fromValue = self.presentation.position
        spin.toValue = SCNVector3(self.presentation.position.x - ShakingDistants ,self.presentation.position.y - ShakingDistants, self.presentation.position.z - ShakingDistants)
        spin.duration = 0.07
        spin.repeatCount = 3
        spin.autoreverses = true
        self.addAnimation(spin, forKey: "postion")
        complete()
    }
    func animateCounter(node: SCNNode, fromValue: CGFloat = 0, toValue: CGFloat = 1){
        DispatchQueue.main.async {
            SCNTransaction.begin()
            node.opacity = fromValue
            SCNTransaction.animationDuration = 5.0
            node.opacity = toValue
            SCNTransaction.commit()
        }
    }
}

let PinkColor = UIColor(red:0.76, green:0.18, blue:0.48, alpha:1.0)
let blueColor = UIColor(red:0.0, green:0.427, blue:0.764, alpha:0.2)
let greenColor = UIColor(red:0.236, green:0.625, blue:0.206, alpha:0.2)
