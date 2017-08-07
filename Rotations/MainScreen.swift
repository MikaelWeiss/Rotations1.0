//
//  MainScreen.swift
//  Rotations
//
//  Created by Mikael Weiss on 6/10/17.
//  Copyright © 2017 MikeStudios. All rights reserved.
//

import UIKit

class MainScreen: UITableViewController {
// MARK: - Variables
    var rotation = ""
    var people: [String] = []
    var assignments: [String] = []
// MARK: - View Stuff
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationTitle.title = rotation
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
        if UserDefaults.standard.object(forKey: "People" + rotation) != nil {
            people = UserDefaults.standard.object(forKey: "People" + rotation) as! [String]
        }
        if UserDefaults.standard.object(forKey: "Assignments" + rotation) != nil {
            assignments = UserDefaults.standard.object(forKey: "Assignments" + rotation) as! [String]
        }
        if tableView.isEditing == true {
            editButtonOutlet.title = "Done"
        }else {
            editButtonOutlet.title = "Edit"
        }
    }
// MARK: - Outlets:
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var editButtonOutlet: UIBarButtonItem!
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
// MARK: - Table view data source:
    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if people.count == assignments.count {
            apendNonAplicable()
            if tableView.isEditing == true {
                if people.isEmpty {
                    tableView.isEditing = true
                    return 2
                }
                return people.count + 2
            }else {
                if people.isEmpty {
                    tableView.isEditing = true
                    return 2
                }
                return people.count
            }
        }else {
            print("else in numberOfRowsInSection")
            apendNonAplicable()
            return people.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if people.isEmpty {
            tableView.isEditing = true
            let Cell = tableView.dequeueReusableCell(withIdentifier: "AddPersonCell", for: indexPath)
            return Cell
        }else if tableView.isEditing {
            if indexPath.row == 0 {
                let Cell = tableView.dequeueReusableCell(withIdentifier: "AddPersonCell", for: indexPath)
                return Cell
            }else if indexPath.row == 1 {
                let Cell = tableView.dequeueReusableCell(withIdentifier: "AddAssignmentCell", for: indexPath)
                return Cell
            }else{
                let Cell = tableView.dequeueReusableCell(withIdentifier: "mainScreenCell", for: indexPath)
                Cell.textLabel?.text = people[indexPath.row - 2]
                Cell.detailTextLabel?.text = assignments[indexPath.row - 2]
                return Cell
            }
        }else {
            let Cell = tableView.dequeueReusableCell(withIdentifier: "mainScreenCell", for: indexPath)
            Cell.textLabel?.text = people[indexPath.row]
            Cell.detailTextLabel?.text = assignments[indexPath.row]
            return Cell
        }
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // The initial row is reserved for adding new items so it can't be deleted or edited.
        if indexPath.row == 0 || indexPath.row == 1 {
            return false
        }
        return true
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // The initial row is reserved for adding new items so it can't be moved.
        if indexPath.row == 0 || indexPath.row == 1 {
            return false
        }
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle != .delete {
            return
        }
        // create the alert
        let alert = UIAlertController(title: "Deleting", message: "Do you want to delete the person or the assignment from this rotation?", preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Person", style: UIAlertActionStyle.default, handler: { (PersonPressed) in
            self.people.remove(at: indexPath.row)
        }))
        alert.addAction(UIAlertAction(title: "Assignment", style: UIAlertActionStyle.default, handler: {
            (AssignmentsPressed) in
            self.assignments.remove(at: indexPath.row)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
// MARK: - TextFieldDelegate
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            if textField.text != "" {
                if textField.tag == 1 {
                    if people.isEmpty == false {
                        if people.contains(textField.text! as String) {
                            AlertAction(Title: "Person Exists", Message: "This person already exists in this rotation", alerTitle: "OK")
                        }else {
                            people.append(textField.text!)
                            UserDefaults.standard.setValue(people, forKey: "People" + rotation)
                        }
                    }else {
                        people.append(textField.text!)
                        UserDefaults.standard.setValue(people, forKey: "People" + rotation)
                    }
                }else if textField.tag == 2 {
                    if assignments.isEmpty == false {
                        if assignments.contains(textField.text! as String) {
                            AlertAction(Title: "assignment Exists", Message: "This assignment already exists in this rotation", alerTitle: "OK")
                        }else {
                            assignments.append(textField.text!)
                            UserDefaults.standard.setValue(assignments, forKey: "Assignments" + rotation)
                        }
                    }else {
                        assignments.append(textField.text!)
                        UserDefaults.standard.setValue(assignments, forKey: "Assignments" + rotation)
                    }
                }
            }
            textField.text = ""
            tableView.reloadData()
            return true
        }
// MARK: - Costome functions:
    func apendNonAplicable() {
        while people.count != assignments.count {
            if people.count < assignments.count {
                while people.count < assignments.count {
                    people.append("this")
                }
            }else if people.count > assignments.count {
                while people.count > assignments.count {
                    assignments.append("this")
                }
            }
        }
    }
    func AlertAction(Title: String, Message: String, alerTitle: String) {
        // create the alert
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: alerTitle, style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
// MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
