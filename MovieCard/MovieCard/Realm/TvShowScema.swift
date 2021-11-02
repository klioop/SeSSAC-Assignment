//
//  TvShowScema.swift
//  MovieCard
//
//  Created by klioop on 2021/11/02.
//

import Foundation
import RealmSwift

class TvShowScema: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var title: String
    @Persisted var releaseDate: String
    @Persisted var genre: List<String?>
    @Persisted var region: String
    @Persisted var overview: String
    @Persisted var rate: String
    @Persisted var starring: String?
    @Persisted var posterImageUrl: String?
    @Persisted var backDropImageUrl: String?
    
    init(
        title: String,
        releaseDate: String,
        genre: [String],
        region: String,
        overview: String,
        rate: String,
        starring: String?,
        posterImageUrl: String?,
        backDropImageUrl: String?
    ) {
        let genreList = List<String?>()
        genreList.append(objectsIn: genre)
        
        self.title = title
        self.releaseDate = releaseDate
        self.genre = genreList
        self.region = region
        self.overview = overview
        self.rate = rate
        self.posterImageUrl = posterImageUrl
        self.backDropImageUrl = backDropImageUrl
    }

    
}
