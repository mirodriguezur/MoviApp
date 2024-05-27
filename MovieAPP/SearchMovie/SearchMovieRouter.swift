//
//  SearchMovieRouter.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 26/05/24.
//

import Foundation

public final class SearchMovieRouter {
    static func createSearchMovieViewController() -> SearchMovieViewController {
        let interactor = SearchMovieInteractor()
        let presenter = SearchMoviePresenter(interactor: interactor)
        let view = SearchMovieViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
}
