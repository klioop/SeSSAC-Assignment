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
        contentView.addSubview(profileImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = contentView.frame.height - 16
        profileImageView.frame = CGRect(
            x: (contentView.frame.width - imageSize) / 2,
            y: 8,
            width: imageSize,
            height: imageSize
        )
    }
    
    func configure(for image: UIImage?) {
        profileImageView.image = image
    }
    
}
