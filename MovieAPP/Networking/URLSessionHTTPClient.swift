//
//  URLSessionHTTPClient.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {
    
    private let apiKey: String = "ef30bdf923f88a7f6ced5bfc065076b7"
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        let validUrl = completeUrl(url)
        session.dataTask(with: validUrl) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
    }
    
    private func completeUrl(_ url: URL) -> URL {
        let validUrl = url.absoluteString + "?api_key=" + apiKey
        return URL(string: validUrl)!
    }
}
