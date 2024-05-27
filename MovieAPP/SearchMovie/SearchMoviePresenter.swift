//
//  SearchMoviePresenter.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 26/05/24.
//

import Foundation

public protocol SearchMoviePresenterInput {
    var listOfMovies: [GeneralMovieEntity] { get }
    func handleSearchButtonTapped(with title: String)
}

public final class SearchMoviePresenter: SearchMoviePresenterInput {
    weak var view: SearchMovieViewControllerProtocol?
    private let interactor: SearchMovieInteractorInput
    public var listOfMovies: [GeneralMovieEntity] = []
    
    public init(interactor: SearchMovieInteractorInput) {
        self.interactor = interactor
    }
    
    public func handleSearchButtonTapped(with title: String) {
        interactor.loadMovies(with: title) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.listOfMovies = movies
                self.view?.update()
            case let .failure(error):
                switch error {
                case .connectivity:
                    self.view?.showConnectivityErrorAlert()
                case .movieNotFound:
                    self.view?.showMovieNotFoundErrorAlert()
                }
            }
        }
    }
}
