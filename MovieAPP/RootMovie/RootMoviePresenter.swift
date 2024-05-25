//
//  RootMoviePresenter.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import Foundation

public protocol RootMoviePresenterInput: AnyObject {
    var listOfMovies: [GeneralMovieEntity] { get }
    func onViewAppear()
    func handleSegmentedControllerTapped()
}

public final class RootMoviePresenter: RootMoviePresenterInput {
    private let router: RootMovieRouter
    private let interactor: RootMovieInteractorInput
    weak var view: RootMovieViewControllerProtocol?
    public var listOfMovies: [GeneralMovieEntity] = []
    
    init(interactor: RootMovieInteractorInput, router: RootMovieRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Protocol Methods
    public func onViewAppear() {
        interactor.loadMovies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.listOfMovies = movies
                self.view?.update()
            case .failure(_):
                self.view?.showErrorAlert()
            }
        }
    }
    
    public func handleSegmentedControllerTapped() {
        // TODO: Implement the logic
    }
    
}
