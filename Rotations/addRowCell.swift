//
//  addRowCell.swift
//  Rotations
//
//  Created by Mikael Weiss on 6/9/17.
//  Copyright © 2017 MikeStudios. All rights reserved.
//

import UIKit

class addRowCell: UITableViewCell {
    var currentName: String?
    @IBAction func EditDidEnd(_ sender: UITextField) {
        currentName = sender.text
    }
    
}
