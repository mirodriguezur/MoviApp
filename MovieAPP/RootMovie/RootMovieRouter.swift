//
//  RootMovieRouter.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import Foundation

public protocol RootMovieRouterProtocol {
    func navigateToFilterMovieModule()
    func navigateToDetailMovie(with movie: GeneralMovieEntity)
    func navigateToSearchMovieModule()
}

public final class RootMovieRouter: RootMovieRouterProtocol {
    var viewController: RootMovieViewController?
    
    public init(){}
    
    public func navigateToFilterMovieModule() {
        let filterMovieViewController = FilterMovieRouter.createFilterMovieViewController()
        self.viewController?.navigationController?.pushViewController(filterMovieViewController, animated: true)
    }
    
    public func navigateToDetailMovie(with movie: GeneralMovieEntity) {
        let detailMovieViewController = DetailMovieRouter.createDetailMovieViewController(with: movie)
        self.viewController?.present(detailMovieViewController, animated: true)
    }
    
    public func navigateToSearchMovieModule() {
        let searchMovieViewController = SearchMovieRouter.createSearchMovieViewController()
        self.viewController?.navigationController?.pushViewController(searchMovieViewController, animated: true)
    }
}
