//
//  HomeController.swift
//  SeSAC-week06
//
//  Created by klioop on 2021/11/01.
//

import UIKit

class HomeViewController: UIViewController {
    
    static let sbID = "HomeViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapPlusButton(_ sender: UIBarButtonItem) {
        let bundle = Bundle(for: AddViewController.self)
        let sb = UIStoryboard(name: "Content", bundle: bundle)
        guard let navVC = sb.instantiateInitialViewController() as? UINavigationController else { return }
        
        present(navVC, animated: true)
    }
}
