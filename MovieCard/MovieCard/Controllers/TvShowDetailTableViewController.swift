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
    
    // MARK: - private variables
    
    private var isHeaderBtnTapped = false
    
    private var starringArray: [String] {
        if let tvShow = tvShowInfo {
            var names: [String] = []
            if let temp = tvShow.starring {
                names = temp.components(separatedBy:", ")
            }
            let result = names.map { name -> String in
                if name.contains("-") {
                    return name.replacingOccurrences(of: "-", with: "")
                }
                return name
            }
            return result.filter { !$0.isEmpty }
        }
        return []
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCellAndHeader()
        let apiManager: APIManager = .shared
        guard let tvShow = tvShowInfo, let url = apiManager.url(
            endpoint: .image,
            pathParameters: [tvShow.posterImageUrl ?? "?"]
        )  else { return }
        backDropImageView.kf.setImage(with: url)
    }
    
    // MARK: - private functions
    
    private func registerCellAndHeader() {
        let nib = UINib(nibName: DefaultTableViewCell.cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DefaultTableViewCell.cellIdentifier)
        tableView.register(LabelHeaderView.self, forHeaderFooterViewReuseIdentifier: LabelHeaderView.headerIdentifier)
    }
    
    private func dequeueAndConfigure(
        at indexPath: IndexPath,
        from tableView: UITableView
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.cellIdentifier, for: indexPath)
                as? DefaultTableViewCell else { fatalError("Could not find the cell") }
        
        cell.defaultImageView.image = UIImage(named: tvShowInfo?.title ?? "?")
        cell.titleLabel.text = starringArray[indexPath.row]
        cell.subTitleLabel.text = "Hello"
        
        posterImageView.image = UIImage(named: tvShowInfo?.title ?? "?")
        
        return cell
    }
    
    private func unfoldHeaderView(_ headerView: LabelHeaderView) {
        UIView.animate(withDuration: 0.2) {
            headerView.label.sizeToFit()
            headerView.label.frame = CGRect(
                x: 10,
                y: 0,
                width: headerView.contentView.frame.width - 20,
                height: headerView.label.frame.height
            )
            headerView.button.transform = CGAffineTransform.identity.rotated(by: .pi)
            headerView.frame.size.height = headerView.label.frame.height + 42
            headerView.layoutSubviews()
            self.view.layoutSubviews()
        }
    }
    
    private func foldHeaderView(_ headerView: LabelHeaderView) {
        UIView.animate(withDuration: 0.2) {
            headerView.label.frame = CGRect(
                x: 10,
                y: 0,
                width: headerView.contentView.frame.width - 20,
                height: 100 / 2
            )
            headerView.frame.size.height = 100
            headerView.button.transform = CGAffineTransform.identity.rotated(by: .pi * 2)
            headerView.layoutSubviews()
            
            self.view.layoutSubviews()
        }
    }

    // MARK: - Table view data source and delegate

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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: LabelHeaderView.headerIdentifier)
                as? LabelHeaderView else { fatalError() }
        
        headerView.button.addTarget(self, action: #selector(headerBtnTapped), for: .touchUpInside)
        headerView.label.text = tvShowInfo?.overview
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        LabelHeaderView.prefferedHeight
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.isHeaderBtnTapped {
            let headerView = tableView.headerView(forSection: 0) as! LabelHeaderView
            foldHeaderView(headerView)
            self.isHeaderBtnTapped = false
        }
    }
    
    // MARK: - objc func
    
    @objc
    func headerBtnTapped() {
        self.isHeaderBtnTapped.toggle()
        let headerView = tableView.headerView(forSection: 0) as! LabelHeaderView
        
        if self.isHeaderBtnTapped {
            unfoldHeaderView(headerView)
        } else {
            foldHeaderView(headerView)
        }
    }
}
