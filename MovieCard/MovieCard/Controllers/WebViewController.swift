//
//  WebViewController.swift
//  MovieCard
//
//  Created by klioop on 2021/10/18.
//

import UIKit

class WebViewController: UIViewController {
    
    var tvShow: TvShow?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        navigationItem.title = tvShow?.title
    }

}
