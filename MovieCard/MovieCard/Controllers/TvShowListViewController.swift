//
//  MovieCardListViewController.swift
//  MovieCard
//
//  Created by klioop on 2021/10/17.
//

import UIKit

class TvShowListViewController: UIViewController {
    
    private var tvShows = TvShow.testData
    
    @IBOutlet weak var headerImageContainer: UIView! {
        didSet {
            headerImageContainer.layer.shadowOpacity = 0.8
            headerImageContainer.layer.shadowRadius = 2
            headerImageContainer.layer.shadowOffset = CGSize(width: 1, height: 1)
            headerImageContainer.layer.cornerRadius = 6
        }
    }
    
    @IBOutlet weak var tvTableView: UITableView! {
        didSet {
            tvTableView.delegate = self
            tvTableView.dataSource = self
        }
    }
    
    @IBAction func searchButtonTouched(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "SearchView", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SearchViewController.sbIdentifier)
        let navCon = UINavigationController(rootViewController: vc)
        navCon.modalPresentationStyle = .fullScreen
        
        present(navCon, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
}

extension TvShowListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TvShowCardTableViewCell.cellIdentifier, for: indexPath)
                as! TvShowCardTableViewCell
        
        let tvShow = tvShows[indexPath.row]
        cell.configure(
            date: tvShow.releaseDate,
            genre: tvShow.genre,
            rating: tvShow.rate,
            name: tvShow.title,
            starring: tvShow.starring
        ) {
            let vc = WebViewController()
            let navCon = UINavigationController(rootViewController: vc)
            
            vc.tvShow = tvShow
            self.present(navCon, animated: true, completion: nil)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        TvShowCardTableViewCell.prefferedHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "TvShowDetail", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: TvShowDetailTableViewController.stroryBoardID)
                as? TvShowDetailTableViewController else { return }
        let tvShowInfo = tvShows[indexPath.row]
        
        vc.tvShowInfo = tvShowInfo
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

