//
//  WaterTakeInLabelCell.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import UIKit

class WaterTakeInLabelCell: UITableViewCell {
    
    @IBOutlet var label: UILabel!
    
    func configure(for takeIn: Int) {
        let text = "잘하셨어요!\n오늘 마신 양은\n\(takeIn)ml\n목표의 57%"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.firstLineHeadIndent = 5
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: 20)
        ]
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        
        label.attributedText = attributedText
    }
    
}
