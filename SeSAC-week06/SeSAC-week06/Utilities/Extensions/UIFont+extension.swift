//
//  UIFont+extension.swift
//  SeSAC-week06
//
//  Created by klioop on 2021/11/01.
//

import Foundation
import UIKit

/*
    S-CoreDream-1Thin
    S-CoreDream-2ExtraLight
    S-CoreDream-4Regular
    S-CoreDream-3Light
    S-CoreDream-5Medium
    S-CoreDream-6Bold
    S-CoreDream-7ExtraBold
    S-CoreDream-8Heavy
    S-CoreDream-9Black
*/
extension UIFont {
    
    struct Constants {
        static let basicFontSize: CGFloat = 14
    }
    
    var sCoreDreamThin: UIFont! {
//        UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "S-CoreDream-1Thin", size: 14)!)
        UIFont(name: "S-CoreDream-1Thin", size: Constants.basicFontSize)
    }
    
    var sCoreDreamExtraLight: UIFont! {
        UIFont(name: "S-CoreDream-2ExtraLight", size: Constants.basicFontSize)
    }
    
    var sCoreDreamLight: UIFont! {
        UIFont(name: "S-CoreDream-3Light", size: Constants.basicFontSize)
    }
    
    var sCoreDreamRegular: UIFont! {
        UIFont(name: "S-CoreDream-4Regular", size: Constants.basicFontSize)
    }
    
    var sCoreDreamMedium: UIFont! {
        UIFont(name: "S-CoreDream-5Medium", size: Constants.basicFontSize)
    }
    
    var sCoreDreamBold: UIFont! {
        UIFont(name: "S-CoreDream-6Bold", size: Constants.basicFontSize)
    }
    
    var sCoreDreamExtraBold: UIFont! {
        UIFont(name: "S-CoreDream-7ExtraBold", size: Constants.basicFontSize)
    }
    
    var sCoreDreamHeavy: UIFont! {
        UIFont(name: "S-CoreDream-8Heavy", size: Constants.basicFontSize)
    }
    
    var sCoreDreamBlack: UIFont! {
        UIFont(name: "S-CoreDream-9Black", size: Constants.basicFontSize)
    }
    
}
