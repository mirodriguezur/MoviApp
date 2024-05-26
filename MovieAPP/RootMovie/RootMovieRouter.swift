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
}

public final class RootMovieRouter: RootMovieRouterProtocol {
    var viewController: RootMovieViewController?
    
    public init(){}
    
    public func navigateToFilterMovieModule() {
        let filterMovieViewController = FilterMovieRouter.createFilterMovieViewController()
        self.viewController?.navigationController?.pushViewController(filterMovieViewController, animated: true)
    }
    
    public func navigateToDetailMovie(with movie: GeneralMovieEntity) {
        let detailMovieViewController = DetailMovieRouter.createFilterMovieViewController(with: movie)
        self.viewController?.present(detailMovieViewController, animated: true)
    }
}
