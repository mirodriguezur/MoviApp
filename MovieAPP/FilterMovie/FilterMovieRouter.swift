//
//  FilterMovieRouter.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import Foundation

class FilterMovieRouter {
    static func createFilterMovieViewController() -> FilterMovieViewController {
        let interactor = FilterMovieInteractor()
        let presenter = FilterMoviePresenter(interactor: interactor)
        let view = FilterMovieViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
}
