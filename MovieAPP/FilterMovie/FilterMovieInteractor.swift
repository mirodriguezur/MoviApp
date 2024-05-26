//
//  FilterMovieInteractor.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import Foundation

public protocol FilterMovieInteractorInput {
    func loadFilteredMovies(parameters: FilterMovieParameters, completion: @escaping (FilterMovieInteractor.Result) -> Void)
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
    
    public func loadFilteredMovies(parameters: FilterMovieParameters, completion: @escaping (Result) -> Void) {
        let url = buildUrlComponents(parameters: parameters)
        
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
    
    private func buildUrlComponents(parameters: FilterMovieParameters) -> URL {
        var urlComponents = URLComponents(string: "https://api.themoviedb.org/3/discover/movie")!
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        // Build query items based on filter parameters
        if !parameters.language.isEmpty {
            queryItems.append(.init(name: "with_original_language", value: parameters.language))
        }
        if !parameters.forAdults.isEmpty {
            queryItems.append(.init(name: "include_adult", value: parameters.forAdults))
        }
        if !parameters.average.isEmpty {
            var operatorName: String = "lte"
            if parameters.operatorRange == "lte" {
                operatorName = "vote_average.lte"
            } else if parameters.operatorRange == "gte" {
                operatorName = "vote_average.gte"
            }
            queryItems.append(.init(name: operatorName, value: parameters.average))
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}

private struct Root: Decodable {
    let results: [GeneralMovieEntity]
}
