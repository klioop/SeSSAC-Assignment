//
//  GoalLabelCell.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/12.
//

import UIKit

class GoalLabelCell: UITableViewCell {
    
    @IBOutlet var label: UILabel!
    
    func configure(for name: String, goal: Double) {
        let goalString = String(format: "%.1f", goal)
        
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.text = "\(name) 님의 하루 물 권장 섭취량은 \(goalString)L 입니다."
    }
    
}
