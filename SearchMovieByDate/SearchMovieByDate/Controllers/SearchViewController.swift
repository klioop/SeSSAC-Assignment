//
//  SearchViewController.swift
//  SearchMovieByDate
//
//  Created by klioop on 2021/10/26.
//

import UIKit
import SwiftyJSON

typealias GetMoives = (_ query: String, @escaping (Result<JSON, Error>) -> Void) -> Void

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!

    @IBOutlet weak var resultTableView: UITableView!
    
    var movies: [Movie] = []
    
    var getMovies: GetMoives = API.api.searchMovies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "영화 검색"
        configureTableView()
    }
    
    func configureTableView() {
        resultTableView.delegate = self
        resultTableView.dataSource = self
    }

    @IBAction func didTapSearchButton(_ sender: UIButton) {
        getMovies("20211020") { result in
            switch result {
            case .success(let json):
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
