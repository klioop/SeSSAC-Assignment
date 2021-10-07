//
//  CardView.swift
//  DDayTracker
//
//  Created by klioop on 2021/10/07.
//

import UIKit

class CardView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    let backGroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemPink
    
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews(backGroundImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backGroundImageView.frame = bounds
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        layer.cornerRadius = 6
        layer.masksToBounds = true
        
    }

}
