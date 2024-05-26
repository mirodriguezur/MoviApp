//
//  DetailMoviePresenter.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 26/05/24.
//

import Foundation

protocol DetailMoviePresenterInput: AnyObject {
    
}

public final class DetailMoviePresenter: DetailMoviePresenterInput{
    weak var view: DetailMovieViewController?
}
