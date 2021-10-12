//
//  ProfileUserInputCell.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import TextFieldEffects
import UIKit

class ProfileUserInputCell: UITableViewCell {
    
    typealias UserInputChangeAction = (String) -> Void
    
    enum Inputs: Int, CaseIterable {
        case name
        case height
        case weight
        
        func placeHolderText() -> String {
            switch self {
            case .name:
                return "닉네임을 입력해주세요"
            case .height:
                return "키(cm)를 입력해주세요"
            case .weight:
                return "몸무게를 입력해주세요"
            }
        }
    }
    
    let hoshiTextField: HoshiTextField = {
        let hoshi = HoshiTextField()
        hoshi.placeholderColor = .lightGray
        hoshi.borderActiveColor = .systemRed
        
        return hoshi
    }()
    
    var userInputChangeAction: UserInputChangeAction?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(hoshiTextField)
        hoshiTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height: CGFloat = contentView.bounds.height - 10
        hoshiTextField.frame = CGRect(
            x: separatorInset.left,
            y: 5,
            width: contentView.bounds.width - 20,
            height: height
            )
    }
    
    func configure(for text: String?, at row: Int, changeAction: @escaping UserInputChangeAction) {
        let placeHolderText = Inputs(rawValue: row)?.placeHolderText() ?? "?"
        if !(row == 0) {
            hoshiTextField.keyboardType = .numberPad
        }
        
        hoshiTextField.placeholder = placeHolderText
        hoshiTextField.text = text
        userInputChangeAction = changeAction
    }
}

extension ProfileUserInputCell: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if let originalText = textField.text {
            let text = (originalText as NSString).replacingCharacters(in: range, with: string)
            userInputChangeAction?(text)
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
