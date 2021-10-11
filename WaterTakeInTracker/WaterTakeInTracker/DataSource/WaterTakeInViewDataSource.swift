//
//  File.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import UIKit

class WaterTakeInViewDataSource: NSObject {
    
    typealias CurrentWaterTakeInChangeAction = (WaterTakeInInfo) -> Void
    
    enum WaterTakeInSection: Int, CaseIterable {
        case takeIn
        case image
        case input
        
        var numberOfRows: Int {
            switch self {
            case .takeIn, .image, .input:
                return 1
            }
        }
        
        func cellIdentifier(at row: Int) -> String {
            switch self {
            case .takeIn:
                return "WaterTakeInLabelCell"
            case .image:
                return "ImageCell"
            case .input:
                return "UserInputCell"
            }
        }
    }
    
    private var waterTakeInInfo: WaterTakeInInfo
    
    private var currentWaterTakeInChangeAction: CurrentWaterTakeInChangeAction?
    
    init(waterTakeInInfo: WaterTakeInInfo, changeAction: @escaping CurrentWaterTakeInChangeAction) {
        self.waterTakeInInfo = waterTakeInInfo
        self.currentWaterTakeInChangeAction = changeAction
        super.init()
    }
    
    func dequeueAndConfigure(at indexPath: IndexPath, from tableView: UITableView) -> UITableViewCell {
        guard let section = WaterTakeInSection(rawValue: indexPath.section) else {
            fatalError("Section index out of range")
        }
        
        let cellIdentifier = section.cellIdentifier(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        switch section {
        case .takeIn:
            if let waterTakeInLabelCell = cell as? WaterTakeInLabelCell {
                waterTakeInLabelCell.configure(for: waterTakeInInfo.todayTakeIn, with: waterTakeInInfo.perCentGoalString)
            }
        case .image:
            if let imageCell = cell as? ImageCell {
                imageCell.configure(for: waterTakeInInfo.image)
            }
        case .input:
            if let currentWaterInputCell = cell as? CurrentWaterInputCell {
                currentWaterInputCell.configure { currentWaterInputText in
                    if let currentWaterTakeIn = Int(currentWaterInputText) {
                        self.waterTakeInInfo.todayTakeIn += currentWaterTakeIn
                    }
                    self.currentWaterTakeInChangeAction?(self.waterTakeInInfo)
                    tableView.reloadData()
                }
            }
        }
        
        return cell
    }
}

extension WaterTakeInViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        WaterTakeInSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        WaterTakeInSection(rawValue: section)?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dequeueAndConfigure(at: indexPath, from: tableView)
    }
    
}
