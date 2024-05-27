//
//  RootMoviePresenterTests.swift
//  MovieAPPTests
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import XCTest
import MovieAPP

final class RootMoviePresenterTests: XCTestCase {
    var sut: RootMoviePresenter!
    var interactor: RootMovieInteractorSpy!
    var router: RootMovieRouterSpy!
    
    override func setUp() {
        super.setUp()
        interactor = RootMovieInteractorSpy()
        router = RootMovieRouterSpy()
        sut = RootMoviePresenter(interactor: interactor, router: router)
    }

    override func tearDown() {
        interactor = nil
        router = nil
        sut = nil
       super.tearDown()
    }

    func test_onViewAppear_requestListOfPopularMovies() {
        sut.onViewAppear()
        
        XCTAssertTrue(interactor.loadPopularMoviesCalled)
        XCTAssertFalse(interactor.loadTopRatedMoviesCalled)
    }
    
    func test_handleSegmentedControllerTapped_whenPopularIsSelected_requestListOfPopularMovies() {
        let segmentedControllerMode = RootMovieMode.popularMovie
        
        sut.handleSegmentedControllerTapped(with: segmentedControllerMode)
        
        XCTAssertTrue(interactor.loadPopularMoviesCalled)
        XCTAssertFalse(interactor.loadTopRatedMoviesCalled)
    }
    
    func test_handleSegmentedControllerTapped_whenTopRatedIsSelected_requestListOfTopRatedMovies() {
        let segmentedControllerMode = RootMovieMode.topRatedMovie
        
        sut.handleSegmentedControllerTapped(with: segmentedControllerMode)
        
        XCTAssertTrue(interactor.loadTopRatedMoviesCalled)
        XCTAssertFalse(interactor.loadPopularMoviesCalled)
    }
    
    func test_hanleFilterButtonTapped_requestNavigateToFilterMovieModule() {
        sut.handleFilterButtonTapped()
        
        XCTAssertTrue(router.navigateToFilterMovieCalled)
    }
    
    func test_hanleSearchButtonTapped_requestNavigateToFilterMovieModule() {
        sut.handleSearchButtonTapped()
        
        XCTAssertTrue(router.navigateToSearchMovieCalled)
    }
}
