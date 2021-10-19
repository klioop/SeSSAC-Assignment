//
//  SearchViewController.swift
//  MovieCard
//
//  Created by klioop on 2021/10/19.
//

import UIKit

class SearchViewController: UIViewController {
    
    static let sbIdentifier = "SearchViewController"

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: DefaultTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: DefaultTableViewCell.cellIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(triggerCloseBtn)
        )
    }
    
    @objc
    func triggerCloseBtn() {
        dismiss(animated: true, completion: nil)
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
