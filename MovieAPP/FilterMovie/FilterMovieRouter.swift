//
//  FilterMovieRouter.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import Foundation

public protocol FilterMovierRouterProtocol {
    func navigateToDetailMovie(with movie: GeneralMovieEntity)
}

public final class FilterMovieRouter: FilterMovierRouterProtocol {
    public var viewController: FilterMovieViewController?
    
    static func createFilterMovieViewController() -> FilterMovieViewController {
        let interactor = FilterMovieInteractor()
        let router = FilterMovieRouter()
        let presenter = FilterMoviePresenter(interactor: interactor, router: router)
        let view = FilterMovieViewController(presenter: presenter)
        presenter.view = view
        router.viewController = view
        
        return view
    }
    
    public func navigateToDetailMovie(with movie: GeneralMovieEntity) {
        let detailMovieViewController = DetailMovieRouter.createDetailMovieViewController(with: movie)
        self.viewController?.present(detailMovieViewController, animated: true)
    }
}
