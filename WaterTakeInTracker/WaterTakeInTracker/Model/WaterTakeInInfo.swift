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
    var todayTakeIn: Int
    var goal: Int = 2100
    var image: UIImage?
    var height: Int?
    var weight: Int?
    
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
    
}

extension WaterTakeInInfo {
    static var testData: WaterTakeInInfo = WaterTakeInInfo(
        name: "세상이",
        todayTakeIn: 1200,
        goal: 2100, image: UIImage(named: "1-5")
    )
    
}
