//
//  WaterTakeInViewController.swift
//  WaterTakeInTracker
//
//  Created by klioop on 2021/10/11.
//

import UIKit

class WaterTakeInViewContrller: UITableViewController {
    
    private var waterTakeInViewDataSource: WaterTakeInViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waterTakeInViewDataSource = WaterTakeInViewDataSource(waterTakeInInfo: WaterTakeIn.testData)
        tableView.dataSource = waterTakeInViewDataSource
    }
    
}
