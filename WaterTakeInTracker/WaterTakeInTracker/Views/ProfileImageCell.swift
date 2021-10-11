//
//  ProfileImageCell.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import UIKit

class ProfileImageCell: UITableViewCell {
    
    static let preferredHeight: CGFloat = 200
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(profileImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = contentView.bounds
    }
    
    func configure(for image: UIImage?) {
        profileImageView.image = image
    }
    
}
