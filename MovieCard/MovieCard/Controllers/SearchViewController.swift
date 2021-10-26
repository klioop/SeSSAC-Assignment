//
//  SearchViewController.swift
//  MovieCard
//
//  Created by klioop on 2021/10/19.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SearchViewController: UIViewController {
    
    static let sbIdentifier = "SearchViewController"
    
    var movies: [Movie] = []

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: DefaultTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: DefaultTableViewCell.cellIdentifier)
        }
    }
    
    // naver 영화 네트워크
    func fetchMovieData() {
        var url = "https://openapi.naver.com/v1/search/movie.json"
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "b9k_fmXD5I0489ym9jxL",
            "X-Naver-Client-Secret": "_whh_4dX6Y"
        ]
        guard let query = "?query=스파이더맨&display=10&start=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        url += query
        
        AF.request(
            url,
            method: .get,
            headers: headers
        ).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                json["items"].arrayValue.forEach {
                    let title = $0["title"].stringValue
                    let formattedTitile = title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                    let movie = Movie(
                        title: formattedTitile,
                        subTitle: $0["subtitle"].stringValue,
                        image: $0["image"].stringValue,
                        link: $0["link"].stringValue,
                        userRatingData: $0["userRating"].stringValue
                    )
                    self.movies.append(movie)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
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
        fetchMovieData()
    }
    
    @objc
    func triggerCloseBtn() {
        dismiss(animated: true, completion: nil)
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.cellIdentifier, for: indexPath)
                as? DefaultTableViewCell else { fatalError() }
        let movie = movies[indexPath.row]
        
        cell.titleLabel.text = movie.title
        let imageURL = URL(string: movie.image)
        cell.defaultImageView.kf.setImage(with: imageURL)
        cell.subTitleLabel.text = movie.subTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
}
