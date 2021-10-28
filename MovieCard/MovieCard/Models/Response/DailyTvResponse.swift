//
//  DailyTvResponse.swift
//  MovieCard
//
//  Created by klioop on 2021/10/28.
//

import Foundation

struct DailyTvResponse {
    
    static var responses: [DailyTvResponse] = [] 
    
    let title: String
    let rate: Double
    let id: Int
    let posterPath: String
    let backDropImagePath: String
    var genres: [String] = []
    var starring: [String] = []
    let firstAirDate: String
    let overView: String
    let region: String
    
}

