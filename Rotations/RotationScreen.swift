//
//  RotationScreen.swift
//  Rotations
//
//  Created by Mikael Weiss on 5/31/17.
//  Copyright © 2017 MikeStudios. All rights reserved.
//

import UIKit

class RotationScreen: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var groupArray = [""]
    @IBOutlet weak var addButtonOutlet: UIBarButtonItem!
    
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
    @IBOutlet weak var MyTableView: UITableView!
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
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
