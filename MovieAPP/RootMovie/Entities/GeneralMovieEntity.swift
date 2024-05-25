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
    
    public init(id: Int, title: String, overview: String, imageURL: String, votes: Double) {
        self.id = id
        self.title = title
        self.overview = overview
        self.imageURL = imageURL
        self.votes = votes
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, title, overview
        case imageURL = "poster_path"
        case votes = "vote_average"
    }
}
