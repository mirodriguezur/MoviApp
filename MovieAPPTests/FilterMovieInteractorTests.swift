//
//  FilterMovieInteractorTests.swift
//  MovieAPPTests
//
//  Created by Michael Alexander Rodriguez Urbina on 26/05/24.
//

import XCTest
import MovieAPP

final class FilterMovieInteractorTests: XCTestCase {
    var sut: FilterMovieInteractor!
    var client: HTTPClientSpy!
    var url: URL!

    override func setUp() {
        super.setUp()
        url = makeAnyURL()
        client = HTTPClientSpy()
        sut = FilterMovieInteractor(client: client)
    }

    override func tearDown() {
        client = nil
        sut = nil
       super.tearDown()
    }

    func test_load_deliversErrorWhenClientFails() {
        var capturedResults = [FilterMovieInteractor.Result]()
        sut.loadFilteredMovies(parameters: makeParameters()) { capturedResults.append($0)
        }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)
        
        XCTAssertEqual(capturedResults, [.failure(.connectivity)])
    }
    
    func test_load_deliversErrorWhenHTTPResponseIsDiferentTo200() {
        var capturedResults = [FilterMovieInteractor.Result]()
        sut.loadFilteredMovies(parameters: makeParameters()) { capturedResults.append($0) }
        
        let statusResponseWithError = [400, 404, 500, 503]
        statusResponseWithError.forEach { statusCode in
            client.complete(withStatusCode: statusCode)
            XCTAssertEqual(capturedResults, [.failure(.invalidData)])
            capturedResults = []
        }
    }
    
    func test_load_deliversErrorWhenResponseWithInvalidJSON(){
        var capturedResults = [FilterMovieInteractor.Result]()
        sut.loadFilteredMovies(parameters: makeParameters()) { capturedResults.append($0)}
        
        let invalidJSON = Data(bytes: "invalid json", count: 0)
        client.complete(withStatusCode: 200, data: invalidJSON)
        
        XCTAssertEqual(capturedResults, [.failure(.invalidData)])
    }
    
    func test_load_deliversOnlyListOfEnglishMovies_On200HTTPResponse_whenEnglishLanguageIsSelected() {
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
        
        var parameters = makeParameters()
        parameters.setupValidParameters()
        
        var capturedResults = [FilterMovieInteractor.Result]()
        sut.loadFilteredMovies(parameters: parameters) { capturedResults.append($0) }
        
        let json = try! JSONSerialization.data(withJSONObject: moviesJSON)
        client.complete(withStatusCode: 200, data: json)
        
        XCTAssertEqual(capturedResults, [.success([movie1, movie2])])
    }
    
    func test_load_afterTheSutHasBeenDeinitializedItShouldReturnNoResult() {
        var capturedResults = [FilterMovieInteractor.Result]()
        var parameters = makeParameters()
        parameters.setupValidParameters()
        
        sut?.loadFilteredMovies(parameters: parameters) { capturedResults.append($0) }
        
        sut = nil
        client.complete(withStatusCode: 200, data: Data(_: "[{}]".utf8))
        
        XCTAssertTrue(capturedResults.isEmpty)
    }
    
    //MARK: - helpers
    
    func makeSUT() -> (sut: FilterMovieInteractor, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut =  FilterMovieInteractor(client: client)
        return(sut, client)
    }
    
    func makeAnyURL() -> URL {
        URL(string: "https://anyurl.com")!
    }
    
    private func makeParameters(language: String = "English",
                               forAdults: Bool = false,
                               operatorName: Int = 0,
                               average: String = "5") -> FilterMovieParameters {
        return FilterMovieParameters(language: language,
                                     forAdults: forAdults,
                                     operatorName: operatorName,
                                     average: average)
    }
}
