//
//  WaterTakeIn.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import Foundation
import UIKit

struct WaterTakeIn {
    var name: String
    var todayTakeIn: Int
    var goal: Int = 2100
    var image: UIImage?
    
}

extension WaterTakeIn {
    static var testData: WaterTakeIn {
        WaterTakeIn(name: "세상이", todayTakeIn: 1200, goal: 2100, image: UIImage(named: "1-5"))
    }
}
