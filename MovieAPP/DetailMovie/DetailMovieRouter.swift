//
//  DetailMovieRouter.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 26/05/24.
//

import Foundation

public final class DetailMovieRouter {
    static func createFilterMovieViewController(with movie: GeneralMovieEntity) -> DetailMovieViewController {
        let presenter = DetailMoviePresenter()
        let view = DetailMovieViewController(movie: movie)
        presenter.view = view
        
        return view
    }
}
