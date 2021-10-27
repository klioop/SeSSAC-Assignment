//
//  APIManager.swift
//  MovieCard
//
//  Created by klioop on 2021/10/28.
//

import Foundation
import Alamofire
import SwiftyJSON

struct APIManager {
    static let shared = APIManager()
    
    struct Constants {
        static let baseUrl = "https://api.themoviedb.org/3/trending/"
        static let key = Key.trendMediaKey
    }
    
    enum APIError: Error {
        case invalidURL
    }
    
    func makeUrlQueryString(queryParams: [String: String] = [:]) -> String {
        var queryItems = [URLQueryItem]()
        
        for (key, value) in queryParams {
            queryItems.append(.init(name: key, value: value))
        }
        queryItems.append(.init(name: "key", value: Constants.key))
        
        return queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
    }
    
    func makeURLPathParameters(with strings: [String] = []) -> String {
        let pathParameters = strings.joined(separator: "/")
        return pathParameters
    }
    
    private func url(queryParams: [String: String] = [:], pathParameters: [String] = []) -> URL? {
        var urlString = Constants.baseUrl
        let pathParameterString = makeURLPathParameters(with: pathParameters)
        let queryString = makeUrlQueryString(queryParams: queryParams)
        
        urlString += pathParameterString
        urlString += "?" + queryString
        
        return URL(string: urlString)
    }
    
    private func request(url: URL?, completion: @escaping (Result<JSON, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(.success(json))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
