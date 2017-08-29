//
//  Settings.swift
//  Rotations
//
//  Created by Mikael Weiss on 5/31/17.
//  Copyright © 2017 MikeStudios. All rights reserved.
//

import UIKit

class Settings: UITableViewController {
// MARK: - System Stuff
    override func viewDidLoad() {
        super.viewDidLoad()
        setSwitches(key: "ManualRotateButton", senderSwitch: ManualRotateButton)
        setSwitches(key: "NotifyWhenRotates", senderSwitch: NotifyWhenRotates)
        setSwitches(key: "HideEdit", senderSwitch: HideEdit)
    }
// MARK: - Outlets

    @IBOutlet weak var ManualRotateButton: UISwitch!
    @IBOutlet weak var NotifyWhenRotates: UISwitch!
    @IBOutlet weak var HideEdit: UISwitch!
    @IBOutlet weak var ColorSegmentedControlOutlet: UISegmentedControl!
// MARK: - Actions:
    
    @IBAction func HideEditChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "HideEdit")
    }
    @IBAction func NotifyWhenRotatesChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "NotifyWhenRotates")
    }
    @IBAction func ManualRotateButtonChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "ManualRotateButton")
    }
    @IBAction func ColorSegmentedControler(_ sender: UISegmentedControl) {
        if ColorSegmentedControlOutlet.selectedSegmentIndex == 0 {
            ColorSegmentedControlOutlet.tintColor = UIColor(red:0.00, green:0.49, blue:1.00, alpha:1.0)
        }else if ColorSegmentedControlOutlet.selectedSegmentIndex == 1 {
            ColorSegmentedControlOutlet.tintColor = UIColor(red:0.48, green:0.84, blue:0.00, alpha:1.0)
        }else if ColorSegmentedControlOutlet.selectedSegmentIndex == 2 {
            ColorSegmentedControlOutlet.tintColor = UIColor(red:1.00, green:0.59, blue:0.00, alpha:1.0)
        }else if ColorSegmentedControlOutlet.selectedSegmentIndex == 3 {
            ColorSegmentedControlOutlet.tintColor = UIColor(red:1.00, green:0.22, blue:0.14, alpha:1.0)
        }else if ColorSegmentedControlOutlet.selectedSegmentIndex == 4 {
            ColorSegmentedControlOutlet.tintColor = UIColor(red:0.74, green:0.06, blue:0.88, alpha:1.0)
        }
    }
    
// MARK: - costome functions:
    func setSwitches(key: String, senderSwitch: UISwitch) {
        if (UserDefaults.standard.object(forKey: key) == nil){
            setValue(UserDefaultsValue: key, SenderButton: senderSwitch)
        }else {
            let BoolValue = UserDefaults.standard.bool(forKey: key)
            senderSwitch.setOn(BoolValue, animated: true)
        }
        
    }
    func setValue(UserDefaultsValue: String, SenderButton: UISwitch) {
        UserDefaults.standard.set(false, forKey: UserDefaultsValue)
        SenderButton.setOn(false, animated: true)
    }

}
