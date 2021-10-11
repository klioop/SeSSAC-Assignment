//
//  WaterTakeInLabelCell.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import UIKit

class WaterTakeInLabelCell: UITableViewCell {
    
    @IBOutlet var label: UILabel!
    
    func configure(for takeIn: Int, with percentString: String) {
        let text = "잘하셨어요!\n오늘 마신 양은\n\(takeIn)ml\n목표의 \(percentString)%"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.firstLineHeadIndent = 5
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: 20)
        ]
        
        let attributedText = NSMutableAttributedString(string: text, attributes: attributes)
        
        let locationAndLengthFirst = getLocationAndLength(of: ("은", "l"), from: attributedText)
        
        attributedText.addAttribute(
            .font,
            value: UIFont.systemFont(ofSize: 30, weight: .bold),
            range: .init(location: locationAndLengthFirst.0 + 1, length: locationAndLengthFirst.1)
        )
        
        let locationAndLength = getLocationAndLength(of: ("목", "%"), from: attributedText)
        
        attributedText.addAttribute(
            .font,
            value: UIFont.systemFont(ofSize: 15, weight: .light),
            range: .init(
                location: locationAndLength.0,
                length: locationAndLength.1 + 1
            )
        )
        
        
        label.attributedText = attributedText
    }
    
    private func getLocationAndLength(
        of chars: (Character, Character),
        from attributedString: NSMutableAttributedString
    ) -> (Int, Int) {
        let string = attributedString.string
        let indexOfFirstChar = string.firstIndex(of: chars.0)!
        let location = string.distance(from: string.startIndex, to: indexOfFirstChar)
        let length = string.distance(from: indexOfFirstChar, to: string.firstIndex(of: chars.1)!)
        
        return (location, length)
    }
    
}
