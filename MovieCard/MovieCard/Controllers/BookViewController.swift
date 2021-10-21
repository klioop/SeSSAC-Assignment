//
//  BookViewController.swift
//  MovieCard
//
//  Created by klioop on 2021/10/20.
//

import UIKit
import LoremSwiftum

class BookViewController: UIViewController {
    
    static let sbID = "BookViewController"
    
    @IBOutlet weak var bookCollectionView: UICollectionView! {
        didSet {
            bookCollectionView.delegate = self
            bookCollectionView.dataSource = self
            bookCollectionView.register(
                UINib(nibName: BookCollectionViewCell.cellID, bundle: nil),
                forCellWithReuseIdentifier: BookCollectionViewCell.cellID
            )
            let layout = UICollectionViewFlowLayout()
            bookCollectionView.collectionViewLayout = layout
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.cellID, for: indexPath) as? BookCollectionViewCell else { fatalError() }
        
        cell.titleLabel.text = Lorem.sentence
        cell.ratingLabel.text = "5.5"
        
        return cell
    }
}

extension BookViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 30) / 2
        return CGSize(width: width , height: width )
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        10
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 10, bottom: 0, right: 10)
    }
}


