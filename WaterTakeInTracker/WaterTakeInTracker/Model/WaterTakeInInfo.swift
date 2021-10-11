//
//  WaterTakeIn.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import Foundation
import UIKit

struct WaterTakeInInfo {
    var name: String
    var todayTakeIn: Int = 0
    var goal: Int = 2100
    var image: UIImage?
    var height: Double?
    var weight: Double?
    
    var goalLiter: Double {
        Double(goal) / 1000
    }
    
    var hegithString: String? {
        if let height = height {
            return String(height)
        } else {
            return nil
        }
    }
    
    var weightString: String? {
        if let weight = weight {
            return String(weight)
        } else {
            return nil
        }
    }
    
    var perCentGoalString: String {
            let percentLong = Double(todayTakeIn) / Double(goal)
            let percentShort = percentLong * 100
            let percentShortString = String(format: "%.0f", percentShort)
            
            return percentShortString
    }
    
    var displayImage: UIImage? {
        var image: UIImage?
        if let percentShortInt = Int(self.perCentGoalString) {
            switch percentShortInt {
            case 0..<10:
                image = UIImage(named: "1-1")
            case 10..<20:
                image = UIImage(named: "1-2")
            case 20..<30:
                image = UIImage(named: "1-3")
            case 30..<40:
                image = UIImage(named: "1-4")
            case 40..<50:
                image = UIImage(named: "1-5")
            case 50..<60:
                image = UIImage(named: "1-6")
            case 60..<70:
                image = UIImage(named: "1-7")
            case 70..<80:
                image = UIImage(named: "1-8")
            case 80..<90:
                image = UIImage(named: "1-9")
            default:
                image = UIImage(named: "1-9")
            }
        }
        return image
    }
    
}

extension WaterTakeInInfo {
    static var testData: WaterTakeInInfo = WaterTakeInInfo(
        name: "세상이",
        todayTakeIn: 1200,
        goal: 2100, image: UIImage(named: "1-5")
    )
    
}
