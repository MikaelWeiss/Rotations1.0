//
//  RotationScreen.swift
//  Rotations
//
//  Created by Mikael Weiss on 5/31/17.
//  Copyright © 2017 MikeStudios. All rights reserved.
//

import UIKit

class RotationScreen: UITableViewController, UITextFieldDelegate {
// MARK: - Variables:
    var groupArray: [String] = []
    var rotation = ""
    var isMovingToMainScreen = false
// MARK: - Outlets:
    @IBOutlet weak var editButtonOutlet: UIBarButtonItem!
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
            groupArray = (UserDefaults.standard.object(forKey: "Groups") as? [String])!
        }
        if groupArray.isEmpty {
            tableView.isEditing = true
        }else {
            tableView.isEditing = false
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if isMovingToMainScreen == true {
            let mainScreen = segue.destination as! MainScreen
            mainScreen.rotation = rotation
        }
    }
// MARK: - Actions:
    @IBAction func EditButton(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        if tableView.isEditing == true {
            sender.title = "Done"
        }else {
            sender.title = "Edit"
        }
        tableView.reloadData()
    }
    @IBAction func SettingButton(_ sender: UIBarButtonItem) {
        isMovingToMainScreen = false
        performSegue(withIdentifier: "RotationsToSettings", sender: UIBarButtonItem())
    }
    
// MARK: - TableView Setup:
    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.isEditing == true {
            if groupArray.isEmpty {
                tableView.isEditing = true
                return 1
            }
            return groupArray.count + 1
        }else {
            if groupArray.isEmpty {
                return 1
            }
            return groupArray.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if groupArray.isEmpty {
            tableView.isEditing = true
            let Cell = tableView.dequeueReusableCell(withIdentifier: "addGroupCell", for: indexPath)
            return Cell
        }else if tableView.isEditing {
            if indexPath.row == 0 {
                let Cell = tableView.dequeueReusableCell(withIdentifier: "addGroupCell", for: indexPath)
                return Cell
            }else {
                let Cell = tableView.dequeueReusableCell(withIdentifier: "GroupTitleCell", for: indexPath)
                Cell.textLabel?.text = groupArray[indexPath.row - 1]
                return Cell
            }
        }else {
            let Cell = tableView.dequeueReusableCell(withIdentifier: "GroupTitleCell", for: indexPath)
            Cell.textLabel?.text = groupArray[indexPath.row]
            return Cell
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
        groupArray.remove(at: indexPath.row - 1)
        if UserDefaults.standard.object(forKey: "People" + rotation) != nil {
            UserDefaults.standard.removeObject(forKey: "People" + rotation)
        }
        if UserDefaults.standard.object(forKey: "Assignments" + rotation) != nil {
            UserDefaults.standard.removeObject(forKey: "Assignments" + rotation)
        }
        UserDefaults.standard.set(groupArray, forKey: "Groups")
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = groupArray[sourceIndexPath.row - 1]
        groupArray.remove(at: sourceIndexPath.row - 1)
        groupArray.insert(item, at: destinationIndexPath.row - 1)
        UserDefaults.standard.set(groupArray, forKey: "Groups")
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isMovingToMainScreen = true
        rotation = groupArray[indexPath.row]
        performSegue(withIdentifier: "RotationsToMain", sender: UITableViewCell())
        tableView.deselectRow(at: indexPath, animated: true)
    }
// MARK: - TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != "" {
            if groupArray.isEmpty == false {
                if groupArray.contains(textField.text! as String) {
                    AlertAction(Title: "Group Exists", Message: "This Group Already Exists", alerTitle: "OK")
                }else {
                    groupArray.append(textField.text!)
                    UserDefaults.standard.setValue(groupArray, forKey: "Groups")
                }
            }else {
                groupArray.append(textField.text!)
                UserDefaults.standard.setValue(groupArray, forKey: "Groups")
            }
        }
        textField.text = ""
        tableView.reloadData()
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
