//
//  RotationScreen.swift
//  Rotations
//
//  Created by Mikael Weiss on 5/31/17.
//  Copyright © 2017 MikeStudios. All rights reserved.
//

import UIKit

class RotationScreen: UIViewController,UITableViewDataSource, UITableViewDelegate {
// MARK: - Values:
    var groupArray = [""]
// MARK: - Outlets:
    @IBOutlet weak var addButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var editButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var MyTableView: UITableView!
// MARK: - System Setup:
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if UserDefaults.standard.object(forKey: "Groups") != nil {
            groupArray = UserDefaults.standard.object(forKey: "Groups") as! [String]
        }else {
            groupArray = [""]
        }
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
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
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
        MyTableView.dequeueReusableCell(withIdentifier: "AddGroupCell")
    }
    @IBAction func SettingButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RotationsToSettings", sender: UIBarButtonItem())
    }
    
    
    @IBAction func AddButton(_ sender: UIBarButtonItem) {
        
    }
// MARK: - TableView Setup:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if MyTableView.isEditing == true {
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row <= groupArray.count {
            
            let GroupCell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
            return GroupCell
        }else {
            let AddCell = tableView.dequeueReusableCell(withIdentifier: "AddGroupCell", for: indexPath)
            return AddCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
// MARK: - Costome functions:
    
}
