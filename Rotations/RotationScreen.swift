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
        // PRINT 🖨
        print("View will apear")
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
            // PRINT 🖨
            print("Group Array is not nil in view will apear")
        }else {
            groupArray = nil
            // PRINT 🖨
            print("Group Array is nil in view will apear")
        }
        tableView.isEditing = false
        // PRINT 🖨
        print("IsEditing set to false")
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
// MARK: - Actions:
    @IBAction func EditButton(_ sender: UIBarButtonItem) {
        // PRINT 🖨
        print("editButton")
        tableView.isEditing = !tableView.isEditing
        // PRINT 🖨
        print("Tableview.isEditing = " + String(tableView.isEditing))
        tableView.reloadData()
        // PRINT 🖨
        print("table view.reloadData is done")
//        mabey tableView.addRow? but where do I get the IndexPath
    }
    @IBAction func SettingButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RotationsToSettings", sender: UIBarButtonItem())
    }

// MARK: - TableView Setup:
    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        // PRINT 🖨
        print("NumberOfRowsInSection begun")
        if groupArray == nil {
            // PRINT 🖨
            print("Group Array is nil")
            return 0
        }
        
        // PRINT 🖨
        print("Group Array is not nil")
        return groupArray!.count + 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // PRINT 🖨
        print("Start of cellForRow")
        if isEditing && indexPath.row == 1 {
            // PRINT 🖨
            print("isEditing = True && indexpath.row = 1")
            let Cell = tableView.dequeueReusableCell(withIdentifier: "addGroupCell")
            // PRINT 🖨
            print("Dequeued addGroupCell")
            return Cell!
        }else {
            let Cell = tableView.dequeueReusableCell(withIdentifier: "GroupTitleCell")
            // PRINT 🖨
            print("Dequeued GroupTitleCell")
            return Cell!
        }
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // The initial row is reserved for adding new items so it can't be deleted or edited.
        // PRINT 🖨
        print("CanEditRow begun")
        if indexPath.row == 0 {
            // PRINT 🖨
            print("index path.row = 0")
            return false
        }
        // PRINT 🖨
        print("diferent row")
        return true
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // The initial row is reserved for adding new items so it can't be moved.
        // PRINT 🖨
        print("canMoveRow begun")
        if indexPath.row == 0 {
            // PRINT 🖨
            print("indexPath.row = 0")
            return false
        }
        // PRINT 🖨
        print("diferent Row")
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // PRINT 🖨
        print("commit editingStyle begun")
            if editingStyle != .delete {
                // PRINT 🖨
                print("EditingStyle is not .delete")
                return
            }
        // PRINT 🖨
        print("editingStyle is .delete")
            groupArray?.remove(at: indexPath.row - 1)
        // PRINT 🖨
        print("Deleted From Row")
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // PRINT 🖨
        print("moveRowAt begun")
        let item = groupArray![sourceIndexPath.row - 1]
        groupArray?.remove(at: sourceIndexPath.row - 1)
        groupArray?.insert(item, at: destinationIndexPath.row - 1)
        UserDefaults.standard.set(groupArray, forKey: "Groups")
        // PRINT 🖨
        print("Move Row done")
    }
// MARK: - TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // PRINT 🖨
        print("textField stuff")
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
        // PRINT 🖨
        print("Table view began updates")
        tableView.endUpdates()
        // PRINT 🖨
        print("Table view end updates")
        // PRINT 🖨
        print("Text feild stuff done")
        return true
    }
// MARK: - Costome functions:
    func AlertAction(Title: String, Message: String, alerTitle: String) {
        // PRINT 🖨
        print("alertAction started")
        // create the alert
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: alerTitle, style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
}
