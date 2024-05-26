//
//  GeneralMovieEntity.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import Foundation

public struct GeneralMovieEntity: Decodable, Equatable {
    public var id: Int
    public var title: String
    public var overview: String
    public var imageURL: String
    public var votes: Double
    public var language: String
    public var adult: Bool
    
    public init(id: Int, title: String, overview: String, imageURL: String, votes: Double, language: String, adult: Bool) {
        self.id = id
        self.title = title
        self.overview = overview
        self.imageURL = imageURL
        self.votes = votes
        self.language = language
        self.adult = adult
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, title, overview, adult
        case imageURL = "poster_path"
        case votes = "vote_average"
        case language = "original_language"
    }
}
