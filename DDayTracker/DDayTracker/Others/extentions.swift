//
//  extentions.swift
//  DDayTracker
//
//  Created by klioop on 2021/10/07.
//

import Foundation
import UIKit

// MARK: - UIView

extension DateFormatter {
    
    var prettyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 MM월 dd일"
        
        return formatter
    }
}

extension UIView {
    
    func addSubViews(_ arrayOfViews: [UIView]) {
        arrayOfViews.forEach { self.addSubview($0) }
    }
    
    func addSubViews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}

extension UIView {
    
    var width: CGFloat {
        frame.size.width
    }
    
    var height: CGFloat {
        frame.size.height
    }
    
    var top: CGFloat {
        frame.minY
    }
    
    var bottom: CGFloat {
        frame.maxY
    }
    
    var left: CGFloat {
        frame.minX
    }
    
    var right: CGFloat {
        frame.maxX
    }
    
}
