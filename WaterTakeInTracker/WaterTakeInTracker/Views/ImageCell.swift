//
//  ImageCell.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet var growImageView: UIImageView!
    
    func configure(for image: UIImage?) {
        if let imageView = growImageView {
            imageView.image = image
        }
    }
    
}
