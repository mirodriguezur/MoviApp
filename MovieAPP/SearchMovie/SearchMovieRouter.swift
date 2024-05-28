//
//  SearchMovieRouter.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 26/05/24.
//

import Foundation

public protocol SearchMovieRouterProtocol {
    func navigateToDetailMovie(with movie: GeneralMovieEntity)
}

public final class SearchMovieRouter: SearchMovieRouterProtocol {
    public var viewController: SearchMovieViewController?
    
    static func createSearchMovieViewController() -> SearchMovieViewController {
        let interactor = SearchMovieInteractor()
        let router = SearchMovieRouter()
        let presenter = SearchMoviePresenter(interactor: interactor, router: router)
        let view = SearchMovieViewController(presenter: presenter)
        
        router.viewController = view
        presenter.view = view
        
        return view
    }
    
    public func navigateToDetailMovie(with movie: GeneralMovieEntity) {
        let detailMovieViewController = DetailMovieRouter.createDetailMovieViewController(with: movie)
        self.viewController?.present(detailMovieViewController, animated: true)
    }
}
