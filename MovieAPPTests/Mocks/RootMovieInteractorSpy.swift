//
//  RootMovieInteractorSpy.swift
//  MovieAPPTests
//
//  Created by Michael Alexander Rodriguez Urbina on 26/05/24.
//

import Foundation
import MovieAPP

class RootMovieInteractorSpy: RootMovieInteractorInput {
    
    var loadPopularMoviesCalled = false
    var loadTopRatedMoviesCalled = false
    
    func loadMovies(url: URL, completion: @escaping (MovieAPP.RootMovieInteractor.Result) -> Void) {
    }
    
    func loadPopularMovies(completion: @escaping (MovieAPP.RootMovieInteractor.Result) -> Void) {
        loadPopularMoviesCalled = true
    }
    
    func loadTopRatedMovies(completion: @escaping (MovieAPP.RootMovieInteractor.Result) -> Void) {
        loadTopRatedMoviesCalled = true
    }
}
