//
//  RotationScreen.swift
//  Rotations
//
//  Created by Mikael Weiss on 5/31/17.
//  Copyright © 2017 MikeStudios. All rights reserved.
//

import UIKit

class RotationScreen: UITableViewController, UITextFieldDelegate {
// MARK: - Values:
    var groupArray: [String]?
// MARK: - Outlets:
    @IBOutlet weak var editButtonOutlet: UIBarButtonItem!
//    @IBOutlet weak var MyTableView: UITableView!
// MARK: - System Setup:
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if (UserDefaults.standard.object(forKey: "HideEdit") != nil) {
            //MARK: set up the edit button
            if UserDefaults.standard.bool(forKey: "HideEdit") == true {
                editButtonOutlet.isEnabled = false
                editButtonOutlet.tintColor = UIColor.clear
            }else {
                editButtonOutlet.isEnabled = true
                editButtonOutlet.tintColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
            }
            
        }
        if UserDefaults.standard.object(forKey: "Groups") != nil {
            groupArray = UserDefaults.standard.object(forKey: "Groups") as? [String]
        }else {
            groupArray = nil
        }
        tableView.isEditing = false
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
// MARK: - Actions:
    @IBAction func EditButton(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        tableView.reloadData()
//        mabey tableView.addRow? but where do I get the IndexPath
    }
    @IBAction func SettingButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RotationsToSettings", sender: UIBarButtonItem())
    }

// MARK: - TableView Setup:
    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if groupArray == nil {
            return 0
        }
        
        return groupArray!.count + 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isEditing && indexPath.row == 1 {
            let Cell = tableView.dequeueReusableCell(withIdentifier: "addGroupCell")
            return Cell!
        }else {
            let Cell = tableView.dequeueReusableCell(withIdentifier: "GroupTitleCell")
            return Cell!
        }
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // The initial row is reserved for adding new items so it can't be deleted or edited.
        if indexPath.row == 0 {
            return false
        }
        return true
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // The initial row is reserved for adding new items so it can't be moved.
        if indexPath.row == 0 {
            return false
        }
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle != .delete {
                return
            }
            groupArray?.remove(at: indexPath.row - 1)
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = groupArray![sourceIndexPath.row - 1]
        groupArray?.remove(at: sourceIndexPath.row - 1)
        groupArray?.insert(item, at: destinationIndexPath.row - 1)
        UserDefaults.standard.set(groupArray, forKey: "Groups")
    }
// MARK: - TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != nil {
            if groupArray != nil {
                if (groupArray?.contains(textField.text!))! {
                    AlertAction(Title: "Group Exists", Message: "This Group Already Exists", alerTitle: "OK")
                }else {
                    groupArray?.append(textField.text!)
                    UserDefaults.standard.setValue(groupArray, forKey: "Groups")
                }
            }else {
                groupArray?.append(textField.text!)
                UserDefaults.standard.setValue(groupArray, forKey: "Groups")
            }
        }
        tableView.beginUpdates()
        tableView.endUpdates()
        return true
    }
// MARK: - Costome functions:
    func AlertAction(Title: String, Message: String, alerTitle: String) {
        // create the alert
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: alerTitle, style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
}
