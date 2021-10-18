//
//  MovieCardTableViewCell.swift
//  MovieCard
//
//  Created by klioop on 2021/10/17.
//

import UIKit

class TvShowCardTableViewCell: UITableViewCell {
    
    typealias ClipButtonAction = () -> Void
    
    static let cellIdentifier = "TvShowCardTableViewCell"
    
    static let prefferedHeight: CGFloat = 420

    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var cardContainer: UIView! {
        didSet {
            cardContainer.layer.cornerRadius = 6
            cardContainer.layer.shadowColor = UIColor.black.cgColor
            cardContainer.layer.shadowOpacity = 0.8
            cardContainer.layer.shadowRadius = 3
            cardContainer.layer.shadowOffset = CGSize(width: 2, height: 2)
            cardContainer.layer.masksToBounds = false
            cardContainer.backgroundColor = .secondarySystemBackground
        }
    }
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.layer.cornerRadius = 6
            posterImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var starringLabel: UILabel!
    
    @IBOutlet weak var clipButton: UIButton! {
        didSet {
            clipButton.imageView?.tintColor = .black
        }
    }
    
    @IBAction func clipButtonTouched(_ sender: UIButton) {
        self.clipButtonAction?()
    }
    
    private var clipButtonAction: ClipButtonAction?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .systemBackground
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(
        date: String,
        genre: String,
        rating: Double,
        name: String,
        starring: String,
        clipButtonAction: @escaping ClipButtonAction
    ) {
        releaseDateLabel.text = date
        genreLabel.text = "#\(genre)"
        ratingLabel.text = "\(rating)"
        nameLabel.text = name
        starringLabel.text = starring
        
        self.clipButtonAction = clipButtonAction
    }

}
