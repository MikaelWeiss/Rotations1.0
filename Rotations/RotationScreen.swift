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
    var canAddGroupCell: Bool?
// MARK: - Outlets:
    @IBOutlet weak var addButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var editButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var MyTableView: UITableView!
// MARK: - System Setup:
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addButtonOutlet.isEnabled = false
        addButtonOutlet.tintColor = UIColor.clear
    }
    override func viewWillAppear(_ animated: Bool) {
        if (UserDefaults.standard.object(forKey: "HideEdit") != nil) {
            //MARK: set up the edit button
            if UserDefaults.standard.bool(forKey: "HideEdit") == true {
                editButtonOutlet.isEnabled = false
                editButtonOutlet.tintColor = UIColor.clear
                addButtonOutlet.isEnabled = false
                addButtonOutlet.tintColor = UIColor.clear
            }else {
                editButtonOutlet.isEnabled = true
                editButtonOutlet.tintColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
                addButtonOutlet.isEnabled = false
                addButtonOutlet.tintColor = UIColor.clear
            }
            
        }
        if UserDefaults.standard.object(forKey: "Groups") != nil {
            groupArray = UserDefaults.standard.object(forKey: "Groups") as? [String]
            canAddGroupCell = true
        }else {
            groupArray = nil
            canAddGroupCell = false
        }
        MyTableView.isEditing = false
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
                                                                                // use this to pass on the rotations data?
    }
// MARK: - Actions:
    @IBAction func EditButton(_ sender: UIBarButtonItem) {
        MyTableView.isEditing = !MyTableView.isEditing
        if MyTableView.isEditing == true {
            addButtonOutlet.isEnabled = true
            addButtonOutlet.tintColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
        }else {
            addButtonOutlet.isEnabled = false
            addButtonOutlet.tintColor = UIColor.clear
        }
    }
    @IBAction func SettingButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RotationsToSettings", sender: UIBarButtonItem())
    }
    
    
    @IBAction func AddButton(_ sender: UIBarButtonItem) {
       
    }

// MARK: - TableView Setup:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if groupArray != nil {
            return (groupArray?.count)! + 1
        }else {
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if groupArray != nil {
            if indexPath.row <= (groupArray?.count)! {
                let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTitleCell", for: indexPath)
                cell.detailTextLabel?.text = groupArray?[indexPath.row]
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "addGroupCell", for: indexPath)
                return cell
            }
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addGroupCell", for: indexPath)
            return cell
        }
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
        MyTableView.beginUpdates()
        MyTableView.endUpdates()
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
