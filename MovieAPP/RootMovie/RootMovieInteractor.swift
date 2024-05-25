//
//  RootMovieInteractor.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import Foundation

public protocol RootMovieInteractorInput {}

final public class RootMovieInteractor: RootMovieInteractorInput {
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public enum Result: Equatable {
        case success([GeneralMovieEntity])
        case failure(Error)
    }
    
    public init(url: URL, client: HTTPClient = URLSessionHTTPClient()) {
        self.url = url
        self.client = client
    }
    
    public func loadMovies(completion: @escaping (Result) -> Void) {
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
