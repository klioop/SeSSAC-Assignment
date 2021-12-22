//
//  RoundedImageView.swift
//  TvShow
//
//  Created by klioop on 2021/12/22.
//

import UIKit
import SnapKit

final class RoundedImageView: UIView {
    
    let imageView = RoundedImageView.createImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}

private extension RoundedImageView {
    
    func setConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    static func createImageView() -> UIImageView {
        let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 6
            
            return imageView
        }()
        return imageView
    }
    
}
