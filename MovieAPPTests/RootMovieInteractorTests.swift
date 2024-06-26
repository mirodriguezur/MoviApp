//
//  RootMovieInteractorTests.swift
//  MovieAPPTests
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import XCTest
import Foundation
import MovieAPP

final class RootMovieInteractorTests: XCTestCase {
    var sut: RootMovieInteractor!
    var client: HTTPClientSpy!
    var url: URL!

    override func setUp() {
        super.setUp()
        url = makeAnyURL()
        client = HTTPClientSpy()
        sut = RootMovieInteractor(client: client)
    }

    override func tearDown() {
        client = nil
        sut = nil
       super.tearDown()
    }
    
    func test_load_requestListOfMoviesFromURL() {
        sut.loadMovies(url: makeAnyURL()) { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsListOfItemsFromURL() {
        sut.loadMovies(url: makeAnyURL()) { _ in }
        sut.loadMovies(url: makeAnyURL()) { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorWhenClientFails() {
        var capturedResults = [RootMovieInteractor.Result]()
        sut.loadMovies(url: makeAnyURL()) { capturedResults.append($0)
        }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)
        
        XCTAssertEqual(capturedResults, [.failure(.connectivity)])
    }
    
    func test_load_deliversErrorWhenHTTPResponseIsDiferentTo200() {
        var capturedResults = [RootMovieInteractor.Result]()
        sut.loadMovies(url: makeAnyURL()) { capturedResults.append($0) }
        
        let statusResponseWithError = [400, 404, 500, 503]
        statusResponseWithError.forEach { statusCode in
            client.complete(withStatusCode: statusCode)
            XCTAssertEqual(capturedResults, [.failure(.invalidData)])
            capturedResults = []
        }
    }
    
    func test_load_deliversErrorWhenResponseWithInvalidJSON(){
        var capturedResults = [RootMovieInteractor.Result]()
        sut.loadMovies(url: makeAnyURL()) { capturedResults.append($0)}
        
        let invalidJSON = Data(bytes: "invalid json", count: 0)
        client.complete(withStatusCode: 200, data: invalidJSON)
        
        XCTAssertEqual(capturedResults, [.failure(.invalidData)])
    }
    
    func test_load_deliversListOfMoviesOn200HTTPResponseWithJSONItems() {
        let movie1 = makeMovieItem()
        let movie1JSON = makeJSON(movie: movie1)
        
        let movie2 = makeMovieItem(id: 2, title: "Madagascar")
        let movie2JSON = makeJSON(movie: movie2)
        
        let moviesJSON: [String: Any] = [
            "page": 1,
            "results": [movie1JSON, movie2JSON],
            "total_pages": 1,
            "total_results": 2
            ]
        
        var capturedResults = [RootMovieInteractor.Result]()
        sut.loadMovies(url: makeAnyURL()) { capturedResults.append($0) }
        
        let json = try! JSONSerialization.data(withJSONObject: moviesJSON)
        client.complete(withStatusCode: 200, data: json)
        
        XCTAssertEqual(capturedResults, [.success([movie1, movie2])])
    }
    
    func test_load_afterTheSutHasBeenDeinitializedItShouldReturnNoResult() {
        var capturedResults = [RootMovieInteractor.Result]()
        sut?.loadMovies(url: makeAnyURL()) { capturedResults.append($0)
        }
        
        sut = nil
        client.complete(withStatusCode: 200, data: Data(_: "[{}]".utf8))
        
        XCTAssertTrue(capturedResults.isEmpty)
    }
    
    
    //MARK: - helpers
    
    func makeSUT() -> (sut: RootMovieInteractor, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut =  RootMovieInteractor(client: client)
        return(sut, client)
    }
    
    func makeAnyURL() -> URL {
        URL(string: "https://anyurl.com")!
    }
}
