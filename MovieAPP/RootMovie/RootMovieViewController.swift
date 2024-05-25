//
//  RootMovieViewController.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import UIKit

public protocol RootMovieViewControllerProtocol: AnyObject {}

public final class RootMovieViewController: UIViewController, RootMovieViewControllerProtocol {
    
    public var presenter: RootMoviePresenterInput?

    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

