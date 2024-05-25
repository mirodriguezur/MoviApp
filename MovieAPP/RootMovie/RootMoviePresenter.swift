//
//  RootMoviePresenter.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import Foundation

public protocol RootMoviePresenterInput: AnyObject {
    func onViewAppear()
    func handleSegmentedControllerTapped()
}

public final class RootMoviePresenter: RootMoviePresenterInput {
    private let router: RootMovieRouter
    private let interactor: RootMovieInteractorInput
    weak var view: RootMovieViewControllerProtocol?
    
    init(interactor: RootMovieInteractorInput, router: RootMovieRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Protocol Methods
    public func onViewAppear() {
        // TODO: Implement the logic
    }
    
    public func handleSegmentedControllerTapped() {
        // TODO: Implement the logic
    }
    
}
