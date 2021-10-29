//
//  MovieCardListViewController.swift
//  MovieCard
//
//  Created by klioop on 2021/10/17.
//

import UIKit
import XCTest

class TvShowListViewController: UIViewController {
    
    private var tvShows: [TvShow] = []
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        addTapGesture(to: bookImage)
        fetchListData(completion: { [unowned self] responses in
            self.transformResponseToModel(responses: responses) {
                DispatchQueue.main.async {
                    self.tvTableView.reloadData()
                }
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func fetchListData(completion: @escaping ([DailyTvResponse]) -> Void) {
        APIManager.shared.getMedia(pathParameters: ["tv", "day"]) { result in
            switch result {
            case .success(let json):
                let results = json["results"].arrayValue
                results.forEach { result in
                    let response = DailyTvResponse(
                        title: result["name"].stringValue,
                        rate: result["vote_average"].doubleValue,
                        id: result["id"].intValue,
                        posterPath: result["poster_path"].stringValue,
                        backDropImagePath: result["backdrop_path"].stringValue,
                        firstAirDate: result["first_air_date"].stringValue,
                        overView: result["overview"].stringValue,
                        region: result["origin_country"].arrayValue[0].stringValue
                    )
                    DailyTvResponse.responses.append(response)
                }
                completion(DailyTvResponse.responses)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func fetchDetailAndCredits(of tvID: Int) {
        fetchCredits(of: tvID) {
            self.fetchDetail(of: tvID) { [unowned self] in
                if self.tvShows.filter({ !$0.genre.isEmpty }).count == self.tvShows.count {
                    self.tvTableView.reloadData()
                }
            }
        }
    }
    
    private func fetchDetail(
        of tvID: Int,
        completion: (() -> Void)? = nil
    ) {
        guard let tvShowIdx = tvShows.firstIndex(where: {$0.id == tvID}) else { return }
        var tvShow = tvShows[tvShowIdx]
        
        APIManager.shared.getDetails(pathParameters: ["tv", "\(tvID)"]) { result in
            switch result {
            case .success(let json):
                var genres: [String] = []
                json["genres"].arrayValue.forEach {
                    genres.append($0["name"].stringValue)
                }
                tvShow.genre = genres
                self.tvShows[tvShowIdx] = tvShow
                completion?()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func fetchCredits(
        of tvID: Int,
        completion: (() -> Void)? = nil
    ) {
        guard let tvShowIdx = tvShows.firstIndex(where: {$0.id == tvID}) else { return }
        var tvShow = tvShows[tvShowIdx]
        
        APIManager.shared.getDetails(pathParameters: ["tv", "\(tvID)", "credits"]) { result in
            switch result {
            case .success(let json):
                let names = json["cast"].arrayValue.map { castInfo -> String in
                    castInfo["name"].stringValue
                }
                tvShow.starring = names.joined(separator: ", ")
                self.tvShows[tvShowIdx] = tvShow
                completion?()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func transformResponseToModel(
        responses: [DailyTvResponse],
        completion: @escaping () -> Void
    ) {
        tvShows = responses.map { response -> TvShow in
            let rating = String(format: "%.2f", response.rate)
            let show = TvShow(
                id: response.id,
                title: response.title,
                releaseDate: response.firstAirDate,
                region: response.region,
                overview: response.overView,
                rate: rating,
                posterImageUrl: response.posterPath,
                backDropImageUrl: response.backDropImagePath
            )
            return show
        }
        tvShows.forEach { tvShow in
            fetchDetailAndCredits(of: tvShow.id)
        }
    }
    
    private func addTapGesture(to view: UIView) {
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self , action: #selector(tapGestureRecognized(by:)))
        )
    }
    
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

extension TvShowListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TvShowCardTableViewCell.cellIdentifier, for: indexPath)
        as! TvShowCardTableViewCell
        
        let tvShow = tvShows[indexPath.row]
        let imageUrl = APIManager.shared.url(endpoint: .image, pathParameters: [tvShow.posterImageUrl ?? ""])
        
        DispatchQueue.main.async { [unowned self] in
            self.tvShows[indexPath.row] = tvShow
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
        let tvShowInfo = tvShows[indexPath.row]
        
        vc.tvShowInfo = tvShowInfo
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

