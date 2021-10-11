//
//  UserInputCell.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import UIKit

class UserInputCell: UITableViewCell {
    
    @IBOutlet var textField: UITextField!
    
    func configure(for text: String) {
        textField.text = text
    }
    
}
