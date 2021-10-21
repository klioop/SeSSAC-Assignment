//
//  BookCollectionViewCell.swift
//  MovieCard
//
//  Created by klioop on 2021/10/20.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "BookCollectionViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 6
        contentView.backgroundColor = .systemIndigo
    }

}
