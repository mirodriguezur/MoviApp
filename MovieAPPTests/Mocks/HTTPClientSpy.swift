//
//  HTTPClientSpy.swift
//  MovieAPPTests
//
//  Created by Michael Alexander Rodriguez Urbina on 26/05/24.
//

import Foundation
import MovieAPP

class HTTPClientSpy: HTTPClient {
    
    var requestedURLs = [URL]()
    var completions = [(HTTPClientResult) -> Void]()
    
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        requestedURLs.append(url)
        completions.append(completion)
    }
    
    func complete(with error: Error, at index: Int = 0) {
        completions[index](.failure(error))
    }
    
    func complete(withStatusCode code: Int, data: Data = Data(), at index: Int = 0) {
        let response = HTTPURLResponse(url: requestedURLs[index],
                                       statusCode: code,
                                       httpVersion: nil,
                                       headerFields: nil)!
        completions[index](.success(data, response))
    }
}
