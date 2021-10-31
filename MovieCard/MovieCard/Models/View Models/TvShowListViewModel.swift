//
//  TvShowListViewModel.swift
//  MovieCard
//
//  Created by klioop on 2021/10/30.
//

import Foundation

class TvShowListViewModel {
    
    let model = TvShowModel()
    
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
    
    func fillData(completion: @escaping ([TvShow]) -> Void) -> Void {
        api.getMedia(pathParameters: ["tv", "day"]) { result in
            switch result {
            case .success(let json):
                let results = json["results"].arrayValue
                results.forEach { result in
                    var region: String
                    if result["origin_country"].arrayValue.isEmpty {
                        region = "KR"
                    } else {
                        region = result["origin_country"].arrayValue[0].stringValue
                    }
                    
                    let response = DailyTvResponse(
                        title: result["name"].stringValue,
                        rate: result["vote_average"].doubleValue,
                        id: result["id"].intValue,
                        posterPath: result["poster_path"].stringValue,
                        backDropImagePath: result["backdrop_path"].stringValue,
                        firstAirDate: result["first_air_date"].stringValue,
                        overView: result["overview"].stringValue,
                        region: region
                    )
                    let tvShow = self.transform(response: response)
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
