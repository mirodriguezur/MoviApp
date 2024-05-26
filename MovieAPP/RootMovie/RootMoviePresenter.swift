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
    func handleSegmentedControllerTapped(with mode: RootMovieMode)
    func handleFilterButtonTapped()
}

public enum RootMovieMode {
    case popularMovie
    case topRatedMovie
}

public final class RootMoviePresenter: RootMoviePresenterInput {
    private let router: RootMovieRouter
    private let interactor: RootMovieInteractorInput
    weak var view: RootMovieViewControllerProtocol?
    public var listOfMovies: [GeneralMovieEntity] = []
    
    public init(interactor: RootMovieInteractorInput, router: RootMovieRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Protocol Methods
    public func onViewAppear() {
        handleSegmentedControllerTapped(with: .popularMovie)
    }
    
    public func handleSegmentedControllerTapped(with mode: RootMovieMode) {
        switch mode {
        case .popularMovie:
            interactor.loadPopularMovies { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(movies):
                    self.listOfMovies = movies
                    self.view?.update()
                case let .failure(error):
                    switch error {
                    case .connectivity:
                        self.view?.showConnectivityErrorAlert()
                    case .invalidData:
                        self.view?.showInvalidDataErrorAlert()
                    }
                }
            }
        case .topRatedMovie:
            interactor.loadTopRatedMovies { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(movies):
                    self.listOfMovies = movies
                    self.view?.update()
                case let .failure(error):
                    switch error {
                    case .connectivity:
                        self.view?.showConnectivityErrorAlert()
                    case .invalidData:
                        self.view?.showInvalidDataErrorAlert()
                    }
                }
            }
        }
    }
    
    public func handleFilterButtonTapped() {
        router.navigateToFilterMovieModule()
    }
}
