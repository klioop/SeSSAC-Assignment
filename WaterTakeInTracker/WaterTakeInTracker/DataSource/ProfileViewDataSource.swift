//
//  ProfileViewDataSource.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import UIKit

class ProfileViewDataSource: NSObject {
    
    typealias ProfileChangeAction = (WaterTakeInInfo) -> Void
    
    enum ProfileSection: Int, CaseIterable {
        case image
        case userInput
        
        var numberOfRows: Int {
            switch self {
            case .image:
                return 1
            case .userInput:
                return 3
            }
        }
        
        func cellIdentifier(at row: Int) -> String {
            switch self {
            case .image:
                return "ProfileImageCell"
            case .userInput:
                return "ProfileUserInputCell"
            }
        }
    }
    
    private var waterTakeInInfo: WaterTakeInInfo
    
    var profileChnageAction: ProfileChangeAction?
    
    init(waterTakeInInfo: WaterTakeInInfo, changeAction: @escaping ProfileChangeAction) {
        self.waterTakeInInfo = waterTakeInInfo
        self.profileChnageAction = changeAction
    }
    
    func dequeueAndConfigure(at indexPath: IndexPath, from tableView: UITableView) -> UITableViewCell {
        guard let section = ProfileSection(rawValue: indexPath.section) else {
            fatalError("Section index out of range")
        }
        
        let cellIdentifier = section.cellIdentifier(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        switch section {
        case .image:
            if let profileImageCell = cell as? ProfileImageCell {
                profileImageCell.configure(for: UIImage(named: "1-6"))
            }
        case .userInput:
            if let userInputCell = cell as? ProfileUserInputCell {
                let row = indexPath.row
                let displayText: String?
                
                switch row {
                case 0: displayText = waterTakeInInfo.name
                case 1: displayText = waterTakeInInfo.hegithString
                default: displayText = waterTakeInInfo.weightString
                }
                
                userInputCell.configure(for: displayText, at: row) { text in
                    switch row {
                    case 0:
                        self.waterTakeInInfo.name = text
                    case 1:
                        self.waterTakeInInfo.height = Int(text)
                    default:
                        self.waterTakeInInfo.weight = Int(text)
                    }
                    self.profileChnageAction?(self.waterTakeInInfo)
                }
            }
        }
        
        return cell
    }
    
    
}

extension ProfileViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        ProfileSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ProfileSection(rawValue: section)?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dequeueAndConfigure(at: indexPath, from: tableView)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
}

