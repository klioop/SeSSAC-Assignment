//
//  ShoppingListTableViewCell.swift
//  TableView
//
//  Created by klioop on 2021/10/14.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "ShoppingListCell"

    @IBOutlet weak var memoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
