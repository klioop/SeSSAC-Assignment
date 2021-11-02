//
//  TvShowListViewModel.swift
//  MovieCard
//
//  Created by klioop on 2021/10/30.
//

import Foundation
import SwiftyJSON
import RealmSwift

class TvShowListViewModel {
    
    var data: [TvShow] = []
    
    private let model = TvShowModel()
    
    private let api: APIManager = .shared
    
    
    private func transform(response: DailyTvResponse) -> TvShow {
        let rating = String(format: "%.2f", response.rate)
        return TvShow(
            id: response.id,
            title: response.title,
            releaseDate: response.firstAirDate,
            genre: [],
            region: response.region,
            overview: response.overView,
            rate: rating,
            starring: nil,
            posterImageUrl: response.posterPath,
            backDropImageUrl: response.backDropImagePath
        )
    }
    
    private func makeResponse(from json: JSON) -> DailyTvResponse {
        var region: String
        if json["origin_country"].arrayValue.isEmpty {
            region = "KR"
        } else {
            region = json["origin_country"].arrayValue[0].stringValue
        }
        return DailyTvResponse(
            title: json["name"].stringValue,
            rate: json["vote_average"].doubleValue,
            id: json["id"].intValue,
            posterPath: json["poster_path"].stringValue,
            backDropImagePath: json["backdrop_path"].stringValue,
            firstAirDate: json["first_air_date"].stringValue,
            overView: json["overview"].stringValue,
            region: region
        )
    }
    
    func fillData(completion: @escaping ([TvShow]) -> Void) -> Void {
        api.getMedia(pathParameters: ["tv", "day"]) { [weak self] result in
            switch result {
            case .success(let json):
                let results = json["results"].arrayValue
                
                results.forEach { result in
                    guard let response = self?.makeResponse(from: result),
                          let tvShow = self?.transform(response: response)
                    else { return }
                    TvShow.data.append(tvShow)
                }
                completion(TvShow.data)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func fetchGenresAndCasts(of data: [TvShow], completion: @escaping () -> Void) {
        let group = DispatchGroup()
        data.forEach { [weak self] tvShow in
            group.enter()
            api.getDetailInfo(pathParameters: ["tv", "\(tvShow.id)"]) { json in
                var genres: [String] = []
                json["genres"].arrayValue.forEach {
                    genres.append($0["name"].stringValue)
                }
                self?.model.updateGenres(with: genres, to: tvShow.id)
                group.leave()
            }
            group.enter()
            api.getDetailInfo(pathParameters: ["tv", "\(tvShow.id)", "credits"]) { json in
                let names = json["cast"].arrayValue.map { castInfo -> String in
                    castInfo["name"].stringValue
                }
                self?.model.updateStarring(with: names, to: tvShow.id)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion()
        }
    }
    
}
