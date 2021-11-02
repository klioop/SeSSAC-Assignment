//
//  MovieCardListViewController.swift
//  MovieCard
//
//  Created by klioop on 2021/10/17.
//

import UIKit
import XCTest

class TvShowListViewController: UIViewController {
    
    private var viewModel = TvShowListViewModel()
    
    private let persistanceManager: PersistanceManager = .shared
    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var headerImageContainer: UIView! {
        didSet {
            headerImageContainer.layer.shadowOpacity = 0.8
            headerImageContainer.layer.shadowRadius = 2
            headerImageContainer.layer.shadowOffset = CGSize(width: 1, height: 1)
            headerImageContainer.layer.cornerRadius = 6
        }
    }
    
    @IBAction func mapButtonTouched(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Map", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: MapViewController.sbID)
        
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        
        addTapGesture(to: bookImage)
        setUpData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - private funcs
    
    private func setUpData() {
        if !UserDefaults.hasOnBoarded {
            viewModel.fillData { [unowned self] data in
                self.viewModel.fetchGenresAndCasts(of: data) {
                    self.viewModel.data = TvShow.data
                    self.viewModel.data.forEach { tvShow in
                        let tvShowObject = TvShowScema(
                            idFromAPI: tvShow.id,
                            title: tvShow.title,
                            releaseDate: tvShow.releaseDate,
                            genre: tvShow.genre,
                            region: tvShow.region,
                            overview: tvShow.overview,
                            rate: tvShow.rate,
                            starring: tvShow.starring,
                            posterImageUrl: tvShow.posterImageUrl,
                            backDropImageUrl: tvShow.backDropImageUrl
                        )
                        try? self.persistanceManager.addTvShowObjcetToRealm(tvShowObject)
                        self.tvTableView.reloadData()
                    }
                    UserDefaults.hasOnBoarded = true
                }
            }
        } else {
            let dataObjects = persistanceManager.readTvShowObjectsFromRealm()
            TvShow.data = dataObjects.map { object -> TvShow in
                var genres: [String] = []
                object.genre.forEach {
                    genres.append($0 ?? "?")
                }
                return TvShow(
                    id: object.idFromAPI,
                    title: object.title,
                    releaseDate: object.releaseDate,
                    genre: genres,
                    region: object.region,
                    overview: object.overview,
                    rate: object.rate,
                    starring: object.starring,
                    posterImageUrl: object.posterImageUrl,
                    backDropImageUrl: object.backDropImageUrl
                )
            }
            viewModel.data = TvShow.data
            self.tvTableView.reloadData()
        }
    }
    
    private func addTapGesture(to view: UIView) {
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self , action: #selector(tapGestureRecognized(by:)))
        )
    }
    
    // MARK: - objc
    
    @objc
    func tapGestureRecognized(by recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            let sb = UIStoryboard(name: "BookCollection", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: BookViewController.sbID)
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

// MARK: - extension - tableview

extension TvShowListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TvShowCardTableViewCell.cellIdentifier, for: indexPath)
        as! TvShowCardTableViewCell
        
        let tvShow = viewModel.data[indexPath.row]
        let imageUrl = APIManager.shared.url(endpoint: .image, pathParameters: [tvShow.posterImageUrl ?? ""])
        
        DispatchQueue.main.async { [unowned self] in
            cell.configure(
                date: tvShow.releaseDate,
                genre: tvShow.genre.isEmpty ? "ddd" : tvShow.genre[0],
                rating: tvShow.rate,
                name: tvShow.title,
                starring: tvShow.starring ?? "?",
                posterImageUrl: imageUrl
            ) {
                let vc = WebViewController()
                let navCon = UINavigationController(rootViewController: vc)
                
                vc.tvShow = tvShow
                self.present(navCon, animated: true, completion: nil)
            }
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
        
        let tvShowInfo = viewModel.data[indexPath.row]
        
        vc.tvShowInfo = tvShowInfo
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

