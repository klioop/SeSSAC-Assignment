//
//  ShoppingListViewController.swift
//  TableView
//
//  Created by klioop on 2021/10/14.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.backgroundColor = .systemBlue
            saveButton.setTitle("저장", for: .normal)
            saveButton.setTitleColor(.white, for: .normal)
            saveButton.layer.cornerRadius = 6
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.cellIdentifier)
    }
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.cellIdentifier, for: indexPath)
                as? ShoppingListTableViewCell else {
                    return UITableViewCell()
                }
        if cell.memoLabel == nil {
            print("NILL")
        }
//        cell.memoLabel?.text = "Test"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}
