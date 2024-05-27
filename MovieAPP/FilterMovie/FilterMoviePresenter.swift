//
//  FilterMoviePresenter.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import Foundation

public protocol FilterMoviePresenterInput: AnyObject {
    var listOfMovies: [GeneralMovieEntity] { get }
    func handleSearchButtonTapped(language: String, forAdults:Bool, operatorName: Int, average: String)
}

public final class FilterMoviePresenter: FilterMoviePresenterInput {
    
    weak var view: FilterMovieViewController?
    private let interactor: FilterMovieInteractorInput
    public var listOfMovies: [GeneralMovieEntity] = []
    
    public init(interactor: FilterMovieInteractorInput) {
        self.interactor = interactor
    }
    
    public func handleSearchButtonTapped(language: String, forAdults: Bool, operatorName: Int, average: String) {
        
        var parameters = FilterMovieParameters(language: language,
                                               forAdults: forAdults,
                                               operatorName: operatorName,
                                               average: average)
        parameters.setupValidParameters()
        
        interactor.loadFilteredMovies(parameters: parameters) { [weak self] result in
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
