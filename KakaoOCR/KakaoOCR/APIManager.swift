//
//  APIManager.swift
//  KakaoOCR
//
//  Created by klioop on 2021/10/27.
//

import UIKit.UIImage
import Alamofire
import SwiftyJSON

struct APIManager {
    
    typealias FetchDataCompletion = (Int, JSON) -> Void
    
    static let shared: APIManager = APIManager()
    
    struct Constants {
        static let key = Key.key
        static let baseURL = "https://dapi.kakao.com/v2/vision/text/ocr"
    }
    
    func fetchData(image: UIImage, result: @escaping FetchDataCompletion) {
        let url = Constants.baseURL
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "Authorization": Constants.key
        ]
        guard let data = image.pngData() else { return }
        
        AF.upload(
            multipartFormData: { multipartForm in
                multipartForm.append(data, withName: "image", fileName: "image", mimeType: "png")
        },
            to: url,
            headers: headers
        )
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let code = response.response?.statusCode ?? 500
                    result(code, json)
                case .failure(let error):
                    print(error)
                }
            }
        
    }
    
}
