//
//  UserInputCell.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import UIKit

class CurrentWaterInputCell: UITableViewCell {
    
    typealias CurrentWaterChangeAction = (String) -> Void
    
    @IBOutlet var textField: UITextField! {
        didSet {
            textField.placeholder = "500"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    private var currentWaterChangeAction: CurrentWaterChangeAction?
    
    func configure(changeAction: @escaping CurrentWaterChangeAction) {
        currentWaterChangeAction = changeAction
    }
}

extension CurrentWaterInputCell: UITextFieldDelegate {
    
//    func textField(
//        _ textField: UITextField,
//        shouldChangeCharactersIn range: NSRange,
//        replacementString string: String
//    ) -> Bool {
//        if let originalText = textField.text {
//            let currentWaterInputText = (originalText as NSString).replacingCharacters(in: range, with: string)
//            self.currentWaterChangeAction?(currentWaterInputText)
//        }
//
//
//        return true
//    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let currentWaterInput = textField.text {
            currentWaterChangeAction?(currentWaterInput)
        }
        textField.text = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

