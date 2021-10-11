//
//  ImageCell.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet var growingImageVIew: UIImageView!
    
    func configure(for image: UIImage?) {
        growingImageVIew.image = image
    }
    
}
