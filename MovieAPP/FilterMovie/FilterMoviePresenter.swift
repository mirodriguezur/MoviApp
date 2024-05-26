//
//  FilterMoviePresenter.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import Foundation

protocol FilterMoviePresenterInput {
    
}

public final class FilterMoviePresenter: FilterMoviePresenterInput {
    weak var view: FilterMovieViewController?
    private let interactor: FilterMovieInteractorInput
    
    init(interactor: FilterMovieInteractorInput) {
        self.interactor = interactor
    }
}
