//
//  RootMovieInteractor.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import Foundation

public protocol RootMovieInteractorInput {
    func loadMovies(url: URL, completion: @escaping (RootMovieInteractor.Result) -> Void)
    func loadPopularMovies(completion: @escaping (RootMovieInteractor.Result) -> Void)
    func loadTopRatedMovies(completion: @escaping (RootMovieInteractor.Result) -> Void)
}

final public class RootMovieInteractor: RootMovieInteractorInput {
    
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
    
    public func loadMovies(url: URL, completion: @escaping (Result) -> Void) {
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
    
    public func loadPopularMovies(completion: @escaping (Result) -> Void) {
        let url = URL(string: "https://www.anyvalidurl.com")!
        loadMovies(url: url, completion: completion)
    }
    
    public func loadTopRatedMovies(completion: @escaping (Result) -> Void) {
        let url = URL(string: "https://www.anyvalidurl.com")!
        loadMovies(url: url, completion: completion)
    }
    
}

private struct Root: Decodable {
    let results: [GeneralMovieEntity]
}
