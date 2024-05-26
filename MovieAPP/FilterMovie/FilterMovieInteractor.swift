//
//  FilterMovieInteractor.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import Foundation

public protocol FilterMovieInteractorInput {
    
}

public final class FilterMovieInteractor: FilterMovieInteractorInput {
    
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public enum Result: Equatable {
        case success([GeneralMovieEntity])
        case failure(Error)
    }
    
    public init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }
    
    public func loadFilteredMovies(category: String, completion: @escaping (Result) -> Void) {
        //let url = "https://api.themoviedb.org/3/discover/movie"
        
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie")!
        client.get(from: url) { [weak self] result in
            
            guard self != nil else { return }
            
            switch result {
            case let .success(data, response):
                if response.statusCode == 200, let root = try? JSONDecoder().decode(Root.self, from: data) {
                    completion(.success(root.results))
                } else {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}

private struct Root: Decodable {
    let results: [GeneralMovieEntity]
}
