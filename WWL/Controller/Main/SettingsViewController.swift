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
    
    var notificatioRequest: DateComponents? {
        didSet {
            debugPrint("picked time: \(String(describing: notificatioRequest?.hour?.description)):\(String(describing: notificatioRequest?.minute?.description))")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(handelPickedTime(sender:)), for: .valueChanged)
    }
    
    @objc func handelPickedTime(sender: UIDatePicker){
        let date = sender.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        notificatioRequest = components
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        soundIsON.setOn(userDefult.bool(forKey: Keys.menuSoundKye.rawValue), animated: true)
        isSoundON(isON: userDefult.bool(forKey: Keys.menuSoundKye.rawValue))
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
            if notificatioRequest != nil {
                setNotification(pickeddateComponents: notificatioRequest!)
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
    @objc func doneClick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        setDataPickerTimeButton.titleLabel?.text = "\(notificatioRequest?.hour)"
        stackViews.removeFromSuperview()
    }
    
    @objc func cancelClick() {
        stackViews.removeFromSuperview()
    }
    
    fileprivate func setNotification(pickeddateComponents: DateComponents) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default()
        content.title = "How many days are there in one year"
        content.subtitle = "Do you know?"
        content.body = "Do you really know?"
        content.badge = 1
        
        var date = DateComponents()
        date.hour = pickeddateComponents.hour
        date.minute = pickeddateComponents.minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
