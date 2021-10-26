//
//  API.swift
//  SearchMovieByDate
//
//  Created by klioop on 2021/10/26.
//

import Foundation
import Alamofire
import SwiftyJSON

struct API {
    
    static var api: API {
        API()
    }
    
    struct Constants {
        static let baseUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        static let key = APIKey.key
    }
    
    enum APIError: Error {
        case invalidURL
    }
    
    func searchMovies(query: String, completion: (Result<JSON, Error>) -> Void) {
        guard let safeQueryString = query.addingPercentEncoding(withAllowedCharacters: .whitespaces)
        else { return }
        let queryParams = ["targetDt": query]
    
    }
    
    func makeUrlQueryString(queryParams: [String: String] = [:]) -> String {
        var queryItems = [URLQueryItem]()
        
        for (key, value) in queryParams {
            queryItems.append(.init(name: key, value: value))
        }
        
        queryItems.append(.init(name: "key", value: Constants.key))
        return queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
        
    }
    
    func request(url: URL?, completion: @escaping (Result<JSON, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(.success(json))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func url(queryParams: [String: String] = [:]) -> URL? {
        var urlString = Constants.baseUrl
        let queryString = makeUrlQueryString(queryParams: queryParams)
        
        urlString += "?" + queryString
        return URL(string: urlString)
    }
    
}
