//
//  SearchMovieViewController.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 26/05/24.
//

import UIKit

public protocol SearchMovieViewControllerProtocol: AnyObject {
    func update()
    func showConnectivityErrorAlert()
    func showMovieNotFoundErrorAlert()
}

public final class SearchMovieViewController: UIViewController, SearchMovieViewControllerProtocol {
    private let presenter: SearchMoviePresenterInput
    
    @IBOutlet weak var searchMovieBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    public init(presenter: SearchMoviePresenterInput) {
        self.presenter = presenter
        super.init(nibName: "SearchMovieViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTapGesture()
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        guard let title = searchMovieBar.text?.lowercased() else { return }
        presenter.handleSearchButtonTapped(with: title)
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
    
    public func showMovieNotFoundErrorAlert() {
        let alert = "Movie not found. Please try another one."
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
    
    // MARK: - Setup Tap Gesture
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func setupTableView() {
        tableView.allowsSelection = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        registerCell()
    }
    
    func registerCell() {
        tableView.register(MinimalMovieTableViewCell.self, forCellReuseIdentifier: MinimalMovieTableViewCell.identifier)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.listOfMovies.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MinimalMovieTableViewCell.identifier, for: indexPath) as? MinimalMovieTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(with: presenter.listOfMovies[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = presenter.listOfMovies[indexPath.row]
        presenter.handleCellSelected(with: movie)
    }
    
}
