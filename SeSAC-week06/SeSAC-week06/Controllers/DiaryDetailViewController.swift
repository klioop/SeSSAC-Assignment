//
//  DiaryDetailViewController.swift
//  SeSAC-week06
//
//  Created by klioop on 2021/11/07.
//

import Foundation
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "diaryCell"
    
    let diaryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(diaryImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        diaryImageView.frame = contentView.bounds
    }
}

class DiaryDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let userDiary: UserDiary
    let persistanceManager: PersistanceManager
    
    let titleLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    // MARK: - init
    
    init(userDiary: UserDiary, persistanceManager: PersistanceManager) {
        self.userDiary = userDiary
        self.persistanceManager = persistanceManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageCollectionView)
        
        imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.cellId)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = view.bounds.width
        imageCollectionView.frame.size = CGSize(width: width, height: width)
        imageCollectionView.frame.origin.y = (view.frame.height - imageCollectionView.frame.height) / 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userDiary.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.cellId, for: indexPath) as? ImageCollectionViewCell else { fatalError() }
        
        let imageName = userDiary.images[indexPath.row].name
        let image = persistanceManager.loadImageFromDocumnetDirectory(imageName: imageName)
        cell.diaryImageView.image = image
        
        return cell
    }
}

extension DiaryDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 100, height: collectionView.frame.width - 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
    
}
