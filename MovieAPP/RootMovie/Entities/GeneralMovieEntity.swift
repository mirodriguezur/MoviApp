//
//  GeneralMovieEntity.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import Foundation

public struct GeneralMovieEntity: Decodable {
    public var id: Int
    public var title: String
    public var overview: String
    public var imageURL: String
    public var votes: Double
    
    enum CondingKeys: String, CodingKey {
        case id, title, overview
        case imageURL = "poster_path"
        case votes
    }
}
