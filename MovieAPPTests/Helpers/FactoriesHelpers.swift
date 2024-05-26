//
//  FactoriesHelpers.swift
//  MovieAPPTests
//
//  Created by Michael Alexander Rodriguez Urbina on 26/05/24.
//

import Foundation
import MovieAPP

public func makeMovieItem(id: Int = 1,
                           title: String = "any title",
                           overview: String = "any description",
                           imageURL: String = "https://anyurl.com",
                           votes: Double = 5.0,
                           language: String = "en",
                           adult: Bool = false) -> GeneralMovieEntity {
    GeneralMovieEntity(id: id,
                       title: title,
                       overview: overview,
                       imageURL: imageURL,
                       votes: votes,
                       language: language,
                       adult: adult)
}

public func makeJSON(movie: GeneralMovieEntity) -> [String: Any] {
    return [
        "adult": movie.adult,
        "backdrop_path": "",
        "genre_ids": [28, 12, 878],
        "id": movie.id,
        "original_language": movie.language,
        "original_title": "",
        "overview": movie.overview,
        "popularity": 5.0,
        "poster_path": movie.imageURL,
        "release_date": "2023-02-15",
        "title": movie.title,
        "video": false,
        "vote_average": movie.votes,
        "vote_count": 18
    ]
}
