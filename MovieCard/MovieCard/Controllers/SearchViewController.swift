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

// pagination: prefetch, willDisplayCell, scrollView

class SearchViewController: UIViewController, UITableViewDataSourcePrefetching {
    
    // 셀이 화면에 보이기 전에 필요한 리소스를 덩어리로 미리 다운 받는 기능, cellforRow 보다 이전에 호출됨
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if movies.count - 1 == indexPath.row {
                self.startPage += 20
                print("prefetch:", indexPath)
            }
        }
    }
    // cancel
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소: \(indexPaths)")
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.prefetchDataSource = self
            tableView.register(UINib(nibName: DefaultTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: DefaultTableViewCell.cellIdentifier)
        }
    }
        
    static let sbIdentifier = "SearchViewController"
    
    var movies: [Movie] = []
    
    var startPage = 1
    
    // naver 영화 네트워크
    func fetchMovieData(query: String) {
        var url = "https://openapi.naver.com/v1/search/movie.json"
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "b9k_fmXD5I0489ym9jxL",
            "X-Naver-Client-Secret": "_whh_4dX6Y"
        ]
        guard let query = "?query=\(query)&display=20&start=\(startPage)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
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
                print(json)
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
        searchBar.delegate = self
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
        
        if let imageURL = URL(string: movie.image) {
            cell.defaultImageView.kf.setImage(with: imageURL)
        } else {
            cell.defaultImageView.image = UIImage(systemName: "star")
        }
        
        cell.subTitleLabel.text = movie.subTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    // executed when return button clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let text = searchBar.text {
            movies.removeAll()
            startPage = 1
            fetchMovieData(query: text)
        }
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    // executed when cancel button clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        movies.removeAll()
        tableView.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    // 서치바에서 커서가 깜빡이기 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.setShowsCancelButton(true, animated: true)
    }
}
