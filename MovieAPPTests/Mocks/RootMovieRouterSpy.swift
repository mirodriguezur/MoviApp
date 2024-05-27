//
//  RootMovieRouterSpy.swift
//  MovieAPPTests
//
//  Created by Michael Alexander Rodriguez Urbina on 26/05/24.
//

import Foundation
import MovieAPP

class RootMovieRouterSpy: RootMovieRouterProtocol {
    var navigateToFilterMovieCalled = false
    var navigateToSearchMovieCalled = false
    
    func navigateToSearchMovieModule() {
        navigateToSearchMovieCalled =  true
    }
    
    func navigateToDetailMovie(with movie: MovieAPP.GeneralMovieEntity) {
    }
    
    func navigateToFilterMovieModule() {
        navigateToFilterMovieCalled = true
    }
}
