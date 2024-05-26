//
//  RootMovieRouterSpy.swift
//  MovieAPPTests
//
//  Created by Michael Alexander Rodriguez Urbina on 26/05/24.
//

import Foundation
import MovieAPP

class RootMovieRouterSpy: RootMovieRouterProtocol {
    func navigateToDetailMovie(with movie: MovieAPP.GeneralMovieEntity) {
    }
    
    var navigateToFilterMovieCalled = false
    
    func navigateToFilterMovieModule() {
        navigateToFilterMovieCalled = true
    }
}
