//
//  WaterTakeInViewController.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import UIKit

class WaterTakeInViewContrller: UITableViewController {
    
    typealias ChangeWaterTakeInInfo = (WaterTakeInInfo) -> Void
    
    private var dataSource: UITableViewDataSource?
    
    private var waterTakeInInfo: WaterTakeInInfo?
    
    private var tempWaterTakeInInfo: WaterTakeInInfo?
    
    private var changeInfoAction: ChangeWaterTakeInInfo?
    
    private func configure(with info: WaterTakeInInfo, changeAction: @escaping ChangeWaterTakeInInfo) {
        self.waterTakeInInfo = info
        self.changeInfoAction = changeAction
    }
    
    private func registerProfileCells() {
        tableView.register(ProfileImageCell.self, forCellReuseIdentifier: "ProfileImageCell")
        tableView.register(ProfileUserInputCell.self, forCellReuseIdentifier: "ProfileUserInputCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(with: WaterTakeInInfo.testData) { waterTakeInInfo in
            WaterTakeInInfo.testData = waterTakeInInfo
        }
        registerProfileCells()
        
        setEditing(false, animated: false)
        
        navigationItem.setRightBarButton(editButtonItem, animated: false)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        guard let waterTakeInInfo = waterTakeInInfo else { fatalError("Could not find waterTakeInfo") }
        
        if editing {
            dataSource = ProfileViewDataSource(waterTakeInInfo: waterTakeInInfo) { waterTakeInfo in
                self.tempWaterTakeInInfo = waterTakeInfo
            }
            navigationItem.title = nil
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .cancel,
                target: self,
                action: #selector(triggerCancle)
            )
            editButtonItem.image = nil
            editButtonItem.title = "저장"
        } else {
            if let tempWaterTakeInfo = tempWaterTakeInInfo {
                self.waterTakeInInfo = tempWaterTakeInfo
                self.tempWaterTakeInInfo = nil
                self.changeInfoAction?(tempWaterTakeInfo)
                dataSource = WaterTakeInViewDataSource(waterTakeInInfo: tempWaterTakeInfo)
            } else {
                dataSource = WaterTakeInViewDataSource(waterTakeInInfo: waterTakeInInfo)
            }
            
            navigationItem.title = "물 마시기"
            navigationItem.leftBarButtonItem = nil
            editButtonItem.image = UIImage(systemName: "person.crop.circle")
        }
        
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    @objc
    func triggerCancle() {
        setEditing(false, animated: true)
    }
    
}

extension WaterTakeInViewContrller {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat = 0
        
        if navigationItem.title == nil {
            switch indexPath.section {
            case 0:
                cellHeight = ProfileImageCell.preferredHeight
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
