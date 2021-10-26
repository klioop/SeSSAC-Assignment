//
//  API.swift
//  SearchMovieByDate
//
//  Created by klioop on 2021/10/26.
//

import Foundation

struct API {
    
    static var api: API {
        API()
    }
    
    struct Constants {
        static let baseUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        static let key = APIKey.key
    }
    
    func makeUrlQueryString(queryParams: [String: String] = [:]) -> String {
        var queryItems = [URLQueryItem]()
        
        for (key, value) in queryParams {
            queryItems.append(.init(name: key, value: value))
        }
        
        queryItems.append(.init(name: "key", value: Constants.key))
        return queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
        
    }
    
    private func url(queryParams: [String: String] = [:]) -> URL? {
        var urlString = Constants.baseUrl
        let queryString = makeUrlQueryString(queryParams: queryParams)
        
        urlString += "?" + queryString
        return URL(string: urlString)
    }
    
}
