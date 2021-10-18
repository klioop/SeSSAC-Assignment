//
//  TvShowDetailTableViewController.swift
//  MovieCard
//
//  Created by klioop on 2021/10/18.
//

import UIKit
import Kingfisher

class TvShowDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var backDropImageView: UIImageView! {
        didSet {
            backDropImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    static let stroryBoardID = "TvShowDetailTableViewController"
    
    var tvShowInfo: TvShow?
    
    var starringArray: [String] {
        if let tvShow = tvShowInfo {
            let tempArr = tvShow.starring.components(separatedBy:" ")
            let result = tempArr.indices.map { idx -> String in
                var name = ""
                if idx % 2 == 0 {
                   name = tempArr[idx] + " " + tempArr[idx + 1]
                }
                return name
            }
            return result.filter { !$0.isEmpty }
        }
        return []
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        guard let tvShow = tvShowInfo, let url = URL(string: tvShow.imageUrl) else { return }
        backDropImageView.kf.setImage(with: url)

    }
    
    func registerCell() {
        let nib = UINib(nibName: DefaultTableViewCell.cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DefaultTableViewCell.cellIdentifier)
    }
    
    func dequeueAndConfigure(
        at indexPath: IndexPath,
        from tableView: UITableView
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.cellIdentifier, for: indexPath)
                as? DefaultTableViewCell else { fatalError("Could not find the cell") }
        
        cell.titleLabel.text = starringArray[indexPath.row]
        cell.subTitleLabel.text = "Hello"
        
        return cell
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return starringArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dequeueAndConfigure(at: indexPath, from: tableView)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        DefaultTableViewCell.prefferedHeight
    }


}
