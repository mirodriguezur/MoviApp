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
    
    @IBOutlet weak var tableView: UITableView!
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //TODO: Set UITableView delegates in the storyboard


}

