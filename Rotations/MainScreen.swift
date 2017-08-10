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
    var ifNoAssignment = "No Assignment"
    var ifNoPerson = "No Person"
    var firstPeople: [String] = []
    var firstAssignments: [String] = []
// MARK: - View Stuff
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.rowHeight = 62
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
        setTheRotationsButton(isEditingTableView: false)
        if UserDefaults.standard.object(forKey: "People" + rotation) != nil {
            people = UserDefaults.standard.object(forKey: "People" + rotation) as! [String]
            firstPeople = people
        }
        if UserDefaults.standard.object(forKey: "Assignments" + rotation) != nil {
            assignments = UserDefaults.standard.object(forKey: "Assignments" + rotation) as! [String]
            firstAssignments = assignments
        }
        if firstPeople.isEmpty && firstAssignments.isEmpty {
            tableView.isEditing = true
        }
        if tableView.isEditing == true {
            editButtonOutlet.title = "Done"
            setTheRotationsButton(isEditingTableView: true)
        }else {
            editButtonOutlet.title = "Edit"
            setTheRotationsButton(isEditingTableView: false)
        }
    }
// MARK: - Outlets:
    @IBOutlet weak var RotationButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var editButtonOutlet: UIBarButtonItem!
// MARK: - Actions:
    @IBAction func RotationsButton(_ sender: UIBarButtonItem) {
        reorderArray()
    }
    @IBAction func EditButton(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        if firstPeople.isEmpty && firstAssignments.isEmpty {
            tableView.isEditing = true
        }
        if tableView.isEditing == true {
            sender.title = "Done"
            setTheRotationsButton(isEditingTableView: true)
        }else {
            sender.title = "Edit"
            setTheRotationsButton(isEditingTableView: false)
        }
        tableView.reloadData()
    }
// MARK: - Table view data source:
    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        apendNonAplicable()
        if people.count == assignments.count {
            if tableView.isEditing == true {
                return people.count + 2
            }else {
                return people.count
            }
        }else {
            apendNonAplicable()
            print("else in numberOfRowsInSection")
            return people.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.isEditing {
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
            self.firstPeople.remove(at: indexPath.row - 2)
            self.people = self.firstPeople
//            self.assignments = self.firstAssignments
            print(self.firstPeople)
            tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Assignment", style: UIAlertActionStyle.default, handler: {
            (AssignmentsPressed) in
            self.firstAssignments.remove(at: indexPath.row - 2)
            print(self.firstAssignments)
            self.assignments = self.firstAssignments
            self.people = self.firstPeople
            tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = firstPeople[sourceIndexPath.row]
        firstPeople.remove(at: sourceIndexPath.row)
        firstPeople.insert(item, at: destinationIndexPath.row)
        UserDefaults.standard.set(firstPeople, forKey: "People" + rotation)
        tableView.reloadData()
    }
    
// MARK: - TextFieldDelegate
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField.text != "" {
                if textField.tag == 1 {
                    if people.isEmpty == false {
                        if people.contains(textField.text! as String) {
                            AlertAction(Title: "Person Exists", Message: "This person already exists in this rotation", alerTitle: "OK")
                        }else {
                            firstPeople.append(textField.text!)
                            UserDefaults.standard.setValue(firstPeople, forKey: "People" + rotation)
                            people = firstPeople
                        }
                    }else {
                        firstPeople.append(textField.text!)
                        UserDefaults.standard.setValue(firstPeople, forKey: "People" + rotation)
                        people = firstPeople
                    }
                }else if textField.tag == 2 {
                    if assignments.isEmpty == false {
                        if assignments.contains(textField.text! as String) {
                            AlertAction(Title: "assignment Exists", Message: "This assignment already exists in this rotation", alerTitle: "OK")
                        }else {
                            firstAssignments.append(textField.text!)
                            UserDefaults.standard.setValue(firstAssignments, forKey: "Assignments" + rotation)
                            assignments = firstAssignments
                        }
                    }else {
                        firstAssignments.append(textField.text!)
                        UserDefaults.standard.setValue(firstAssignments, forKey: "Assignments" + rotation)
                        assignments = firstAssignments
                    }
                }
            }
            textField.text = ""
            tableView.reloadData()
            return false
        }
// MARK: - Costome functions:
    func apendNonAplicable() {
        people = firstPeople
        assignments = firstAssignments
        if people.count < assignments.count {
            firstPeople = people
            while people.count < assignments.count {
                people.append(ifNoPerson)
            }
        }else if people.count > assignments.count {
            firstAssignments = assignments
            while people.count > assignments.count {
                assignments.append(ifNoAssignment)
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
    func setTheRotationsButton(isEditingTableView: Bool) {
        if UserDefaults.standard.object(forKey: "ManualRotateButton") != nil {
            if UserDefaults.standard.bool(forKey: "ManualRotateButton") == true {
                if isEditingTableView == true {
                    RotationButtonOutlet.isEnabled = false
                    RotationButtonOutlet.tintColor = UIColor.clear
                }else {
                    RotationButtonOutlet.isEnabled = true
                    RotationButtonOutlet.tintColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
                }
            }else {
                RotationButtonOutlet.isEnabled = false
                RotationButtonOutlet.tintColor = UIColor.clear
            }
        }
    }
    func reorderArray() {
        for _ in 1 ... firstAssignments.count {
            if diceRoll1 != diceRoll2 {
                // Swap elements at index: 2 and 3
                print(firstAssignments)
                swap(&firstAssignments[diceRoll1], &firstAssignments[diceRoll2])
                print(firstAssignments)
            }
            var diceRoll1 = Int(arc4random_uniform(UInt32(firstAssignments.count)) + 1)
            var diceRoll2 = Int(arc4random_uniform(UInt32(firstAssignments.count)) + 1)
            while diceRoll1 == diceRoll2 {
                diceRoll1 = Int(arc4random_uniform(UInt32(firstAssignments.count)) + 1)
                diceRoll2 = Int(arc4random_uniform(UInt32(firstAssignments.count)) + 1)
                if diceRoll1 != diceRoll2 {
                    // Swap elements at index: 2 and 3
                    print(firstAssignments)
                    swap(&firstAssignments[diceRoll1], &firstAssignments[diceRoll2])
                    print(firstAssignments)
                }
            }
            
            UserDefaults.standard.set(firstAssignments, forKey: "Assignments" + rotation)
            tableView.reloadData()
        }
    }
// MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
