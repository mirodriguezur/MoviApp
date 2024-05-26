//
//  RootMovieRouter.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import Foundation

public protocol RootMovieRouterProtocol {
    func navigateToFilterMovieModule()
}

public final class RootMovieRouter: RootMovieRouterProtocol {
    var viewController: RootMovieViewController?
    
    public init(){}
    
    public func navigateToFilterMovieModule() {
        let filterMovieViewController = FilterMovieRouter.createFilterMovieViewController()
        self.viewController?.navigationController?.pushViewController(filterMovieViewController, animated: true)
    }
}
