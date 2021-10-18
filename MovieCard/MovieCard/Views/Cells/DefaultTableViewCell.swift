//
//  DefaultTableViewCell.swift
//  MovieCard
//
//  Created by klioop on 2021/10/18.
//

import UIKit

class DefaultTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "DefaultTableViewCell"
    
    static let prefferedHeight: CGFloat = 100

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var defaultImageView: UIImageView! {
        didSet {
            defaultImageView.layer.cornerRadius = 6
            defaultImageView.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
