//
//  ProfileUserInputCell.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import UIKit

class ProfileUserInputCell: UITableViewCell {
    
    let textField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height: CGFloat = contentView.bounds.height - 10
        textField.frame = CGRect(
            x: 100,
            y: 5,
            width: contentView.bounds.width - 20,
            height: height
            )
    }
    
    func configure(for text: String) {
        textField.placeholder = text
    }
}
