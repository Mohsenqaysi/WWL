//
//  SettingsViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/1/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var setDataPickerTimeButton: UIButton!
    @IBOutlet weak var soundIsON: UISwitch!
    let userDefult = UserDefaults.standard
    var stackViews: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        return view
    }()
    
    var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.backgroundColor = .white
        picker.datePickerMode = .time
        return picker
    }()
    
    // ToolBar
    let toolBar: UIToolbar = {
        let bar = UIToolbar()
        bar.barStyle = .default
        bar.isTranslucent = true
        bar.isUserInteractionEnabled = true
        bar.sizeToFit()
        return bar
    }()
    
    @IBOutlet weak var settingsContainorView: UIView!
    
    var notificatioRequestDateComponents: DateComponents? {
        didSet {
            let time = try! formateTime(dateComponents: notificatioRequestDateComponents!)
            debugPrint(time)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(handelPickedTime(sender:)), for: .valueChanged)
    }
    
    @objc func handelPickedTime(sender: UIDatePicker){
        let date = sender.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        notificatioRequestDateComponents = components
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        soundIsON.setOn(userDefult.bool(forKey: Keys.menuSoundKye.rawValue), animated: true)
        isSoundON(isON: userDefult.bool(forKey: Keys.menuSoundKye.rawValue))
        if let time = userDefult.string(forKey: "time"){
        print("userDefults time: \(time)")
        setDataPickerTimeButton.setTitle("Daily remider at \(time)", for: .normal)
        }
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signOutCurrentUser(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: Keys.isLoggedIn.rawValue)
            UserDefaults.standard.synchronize()
            self.performSegue(withIdentifier: Identifiers.LoggedOut, sender: nil)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func soundIsPlaying(_ sender: UISwitch) {
        debugPrint("ISON:\(sender.isOn)")
        soundIsON.setOn(sender.isOn, animated: true)
        userDefult.set(sender.isOn, forKey: Keys.menuSoundKye.rawValue)
        userDefult.synchronize()
        isSoundON(isON: sender.isOn)
    }
    
    @IBAction func setLocalNotifications(_ sender: UISwitch) {
        if sender.isOn {
            if notificatioRequestDateComponents != nil {
                setNotification(pickeddateComponents: notificatioRequestDateComponents!)
            }
        } else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    @IBAction func setDataPickerTime(_ sender: UIButton) {
        self.pickUpDate()
    }
    
}

extension SettingsViewController: UNUserNotificationCenterDelegate {
    
    //MARK:- handel datePicker
    func pickUpDate(){
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        
        // Set toolBar buttons
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        // MARK: - add stackViews to the settingsContainorView
        stackViews = setUpEmmbededViews(ArrayViews: [toolBar,datePicker])
        self.settingsContainorView.addSubview(stackViews)
        stackViews.frame = self.settingsContainorView.frame
    }
    
    fileprivate func setUpEmmbededViews(ArrayViews: [UIView]) -> UIView {
        let stackView = UIStackView(arrangedSubviews: ArrayViews)
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 5
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }
    
    // MARK:- Button Done and Cancel
    fileprivate func animageSuperView(myView: UIView) {
        UIView.animate(withDuration: 0.2, animations: {myView.alpha = 0.0},
                       completion: {(value: Bool) in
                        myView.removeFromSuperview()
        })
    }
    
    @objc func doneClick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let time = try! formateTime(dateComponents: notificatioRequestDateComponents!)
        setDataPickerTimeButton.titleLabel?.text = time
        userDefult.set(time, forKey: "time")
        userDefult.synchronize()
        if let request = notificatioRequestDateComponents {
            setNotification(pickeddateComponents: request)
        }
        animageSuperView(myView: stackViews)
    }
    
    @objc func cancelClick() {
        animageSuperView(myView: stackViews)
    }
    
    fileprivate func setNotification(pickeddateComponents: DateComponents) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default()
//        guard let hour = pickeddateComponents.hour, pickeddateComponents.hour != nil else { return}
//        guard let mintues = pickeddateComponents.minute, pickeddateComponents.minute != nil else {return}
        let time = try! formateTime(dateComponents: pickeddateComponents)
        content.title = "It's time for fun 😊 \(time)"
        content.body = "Do you know that practice makes perfect"
        content.badge = 1
        
        var date = DateComponents()
        date.hour = pickeddateComponents.hour
        date.minute = pickeddateComponents.minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    enum CustomError: Error {
        case errorhour
        case errorMintues
    }
    
    fileprivate func formateTime(dateComponents: DateComponents) throws -> String{
        guard let hour = dateComponents.hour, dateComponents.hour != nil else {throw CustomError.errorhour}
        guard let mintues = dateComponents.minute, dateComponents.minute != nil else {throw CustomError.errorMintues}
        return "\(hour):\(mintues)"
    }
}
