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
    
    typealias RequestCompletion = (Result<JSON, Error>) -> Void
    
    static let shared = APIManager()
    
    struct Constants {
        static let baseUrlForList = "https://api.themoviedb.org/3/trending/"
        static let baseUrlForImage = "https://image.tmdb.org/t/p/original"
        static let baseUrlForDetail = "https://api.themoviedb.org/3/"
    
        static let key = Key.trendMediaKey
    }
    
    enum EndPoint {
        case list, image, detail
    }
    
    enum APIError: Error {
        case invalidURL
    }
    
    public func getMedia(pathParameters: [String], completion: @escaping RequestCompletion) -> Void {
        guard let url = url(endpoint: .list, pathParameters: pathParameters) else { return }
        request(url: url, completion: completion)
    }
    
    public func getImage(pathParameter: [String], completion: @escaping RequestCompletion) {
        guard let url = url(endpoint: .image, pathParameters: pathParameter) else { return }
        request(url: url, completion: completion)
    }
    
    public func getDetails(pathParameters: [String], completion: @escaping RequestCompletion) {
        guard let url = url(endpoint: .detail, pathParameters: pathParameters) else { return }
        request(url: url, completion: completion)
    }
    
    func makeUrlQueryString(queryParams: [String: String] = [:]) -> String {
        var queryItems = [URLQueryItem]()
        
        for (key, value) in queryParams {
            queryItems.append(.init(name: key, value: value))
        }
        queryItems.append(.init(name: "api_key", value: Constants.key))
        
        return queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
    }
    
    private func url(
        endpoint: EndPoint,
        queryParams: [String: String] = [:],
        pathParameters: [String] = []
    ) -> URL? {
        var base: String
        
        switch endpoint {
        case .list: base = Constants.baseUrlForList
        case .image: base = Constants.baseUrlForImage
        case .detail: base = Constants.baseUrlForDetail
        }
        var urlString = base
        let pathParameterString = pathParameters.joined(separator: "/")
        let queryString = makeUrlQueryString(queryParams: queryParams)
        
        urlString += pathParameterString
        urlString += "?" + queryString
        
        print(urlString)
        
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
