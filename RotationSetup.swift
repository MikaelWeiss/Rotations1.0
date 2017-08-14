//
//  RotationSetup.swift
//  Rotations
//
//  Created by Mikael Weiss on 8/14/17.
//  Copyright © 2017 MikeStudios. All rights reserved.
//

import UIKit

class RotationSetup: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        StartTime.minimumDate = currentDateTime
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// MARK: - Outlets:
    @IBOutlet weak var rotateEvery: UIPickerView!
    @IBOutlet weak var StartTime: UIDatePicker!
    
// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
