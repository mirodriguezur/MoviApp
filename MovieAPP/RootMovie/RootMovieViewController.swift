//
//  RootMovieViewController.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import UIKit

public protocol RootMovieViewControllerProtocol: AnyObject {
    func update()
    func showConnectivityErrorAlert()
    func showInvalidDataErrorAlert()
}

public final class RootMovieViewController: UIViewController, RootMovieViewControllerProtocol {
        
    public var presenter: RootMoviePresenterInput?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            presenter?.handleSegmentedControllerTapped(with: .popularMovie)
            break
        case 1:
            presenter?.handleSegmentedControllerTapped(with: .topRatedMovie)
        default:
            break
        }
    }
    
    @IBAction func filterButtonAction(_ sender: UIBarButtonItem) {
        presenter?.handleFilterButtonTapped()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewAppear()
        setupTableView()
    }
    
    public func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    public func showConnectivityErrorAlert() {
        let alert = "The connection attempt failed. Please try again."
        showAlert(alert)
    }
    
    public func showInvalidDataErrorAlert() {
        let alert = "Invalid data received, please try again."
        showAlert(alert)
    }
    
    private func showAlert(_ alert: String) {
        DispatchQueue.main.async {
            let message = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default)
            message.addAction(action)
            
            self.present(message, animated: true, completion: nil)
        }
    }
}

extension RootMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        registerCell()
    }
    
    func registerCell() {
        tableView.register(BasicMovieTableViewCell.register(), forCellReuseIdentifier: BasicMovieTableViewCell.identifier)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.listOfMovies.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasicMovieTableViewCell.identifier, for: indexPath) as? BasicMovieTableViewCell,
              let movie = presenter?.listOfMovies[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setupCell(with: movie)
        return cell
    }
}

