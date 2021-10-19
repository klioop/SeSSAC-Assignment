//
//  LabelHeaderView.swift
//  MovieCard
//
//  Created by klioop on 2021/10/19.
//

import UIKit
import LoremSwiftum

class LabelHeaderView: UITableViewHeaderFooterView {
    
    typealias ButtonAction = () -> Void
    
    static let headerIdentifier = "LabelHeaderView"
    
    static var prefferedHeight: CGFloat = 100
    
    var count = 0
    
    var buttonAction: ButtonAction?
    
    var label: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.text = Lorem.paragraph
        label.backgroundColor = .systemPink
        
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(label)
        contentView.addSubview(button)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if count == 0 {
            label.frame = CGRect(x: 10, y: 0, width: contentView.frame.width - 20, height: contentView.frame.height / 2)
            count += 1
        }
        
        button.frame = CGRect(
            x: (contentView.frame.width - 32) / 2 ,
            y: label.frame.maxY + 10,
            width: 32,
            height: 32
        )
    }
    
    @objc
    func didTapButton() {
        
        
    }
    
    func configure(buttonAction: @escaping ButtonAction) {
        self.buttonAction = buttonAction
    }
    
    

}
