//
//  ViewController.swift
//  KakaoOCR
//
//  Created by klioop on 2021/10/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ocrImageVIew: UIImageView!
    
    @IBOutlet weak var resultTextView: UITextView!
    
    let api: APIManager = .shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapButton(_ sender: UIButton) {
        api.fetchData(image: ocrImageVIew.image!) { code, json in
            switch code {
            case 200..<300:
                let result = json["result"].arrayValue
                let resultStringArr = result.map { $0["recognition_words"].arrayValue[0].stringValue }
                let resultString = resultStringArr.joined(separator: " ")
                self.resultTextView.text = resultString
            default:
                print("error")
            }
        }
    }
    
}

