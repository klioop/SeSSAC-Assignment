//
//  PersistenceManager.swift
//  MovieCard
//
//  Created by klioop on 2021/11/02.
//

import Foundation
import RealmSwift

final class PersistanceManager {
    
    static let shared = PersistanceManager()
    
    let localRealm = try! Realm()
    
    func trasnformToTvShow(from object: TvShowScema) -> TvShow {
        var genres: [String] = []
        object.genre.forEach {
            if let genre = $0 {
                genres.append(genre)
            }
        }
        return TvShow(
            id: object.idFromAPI,
            title: object.title,
            releaseDate: object.releaseDate,
            genre: genres,
            region: object.region,
            overview: object.overview,
            rate: object.rate,
            starring: object.starring,
            posterImageUrl: object.posterImageUrl,
            backDropImageUrl: object.backDropImageUrl
        )
    }
    
    func readTvShowObjectsFromRealm() -> Results<TvShowScema> {
        localRealm.objects(TvShowScema.self)
    }
    
    func addTvShowObjcetToRealm(_ object: TvShowScema) throws {
        do {
            try localRealm.write {
                localRealm.add(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}


