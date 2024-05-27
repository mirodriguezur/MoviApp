//
//  SearchMovieInteractor.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 26/05/24.
//

import Foundation

public protocol SearchMovieInteractorInput {
    func loadMovies(with title: String, completion: @escaping (SearchMovieInteractor.Result) -> Void)
}

public final class SearchMovieInteractor: SearchMovieInteractorInput {
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case movieNotFound
    }
    
    public enum Result: Equatable {
        case success([GeneralMovieEntity])
        case failure(Error)
    }
    
    public init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }
    
    public func loadMovies(with title: String, completion: @escaping (Result) -> Void) {
        let url = buildUrlComponents(title)
        
        client.get(from: url) { [weak self] result in
            
            guard self != nil else { return }
            
            switch result {
            case let .success(data, response):
                if response.statusCode == 200, let root = try? JSONDecoder().decode(Root.self, from: data) {
                    completion(.success(root.results))
                } else {
                    completion(.failure(.movieNotFound))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
    
    private func buildUrlComponents(_ title: String) -> URL {
        var urlComponents = URLComponents(string: "https://api.themoviedb.org/3/search/movie")!
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        // Encode the movie title to use in a URL
        //let encodeTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        queryItems.append(.init(name: "query", value: title))
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}

private struct Root: Decodable {
    let results: [GeneralMovieEntity]
}
