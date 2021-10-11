//
//  WaterTakeInViewController.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import UIKit

class WaterTakeInViewContrller: UITableViewController {
    
    private var dataSource: UITableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEditing(false, animated: false)
        editButtonItem.image = UIImage(systemName: "person.crop.circle")
        navigationItem.setRightBarButton(editButtonItem, animated: false)
        
        tableView.register(ProfileImageCell.self, forCellReuseIdentifier: "ProfileImageCell")
        tableView.register(ProfileUserInputCell.self, forCellReuseIdentifier: "ProfileUserInputCell")
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            dataSource = ProfileViewDataSource()
            navigationItem.title = nil
        } else {
            dataSource = WaterTakeInViewDataSource(waterTakeInInfo: WaterTakeIn.testData)
        }
        
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
}

extension WaterTakeInViewContrller {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat = 0
        
        if navigationItem.title == nil {
            switch indexPath.section {
            case 0:
                cellHeight = 200
            default:
                cellHeight = 100
            }
        } else {
            switch indexPath.section {
            case 0:
                cellHeight = 200
            case 1:
                cellHeight = 300
            default:
                cellHeight = 50
            }
        }
        
        return cellHeight
    }
}
