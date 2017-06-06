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
