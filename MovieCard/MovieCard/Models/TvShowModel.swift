//
//  TvShowModel.swift
//  MovieCard
//
//  Created by klioop on 2021/10/31.
//

import Foundation

struct TvShowModel {
    
    func getTvShowIdx(with id: Int) -> Int {
        TvShow.data.firstIndex(where: { $0.id == id }) ?? 0
    }
    
    func getTvShow(of idx: Int) -> TvShow {
        TvShow.data[idx]
    }
    
    func index(of tvShow: TvShow) -> Int {
        if let index = TvShow.data.firstIndex(where: {$0.id == tvShow.id }) {
            return index
        }
        return 0
    }
    
    func tvShow(with id: Int) -> TvShow? {
        TvShow.data.first(where: {$0.id == id})
    }
    
    func updateGenres(with genres: [String], to tvID: Int) {
        if var tvShow = tvShow(with: tvID) {
            tvShow.genre = genres
            
            let index = index(of: tvShow)
            TvShow.data[index] = tvShow
        }
    }
    
    func updateStarring(with starring: [String], to tvID: Int) {
        if var tvShow = tvShow(with: tvID) {
            tvShow.starring = starring.joined(separator: ", ")
            
            let index = index(of: tvShow)
            TvShow.data[index] = tvShow
        }
    }
}
