//
//  FilterMovieViewController.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import UIKit

public protocol FilterMovieViewControllerProtocol: AnyObject {
    func update()
    func showConnectivityErrorAlert()
    func showInvalidDataErrorAlert()
}

public final class FilterMovieViewController: UIViewController, FilterMovieViewControllerProtocol {
    
    private let presenter: FilterMoviePresenterInput
    
    @IBOutlet weak var languageTextField: UITextField!
    private let pickerView = UIPickerView()
    
    @IBOutlet weak var adultSwitch: UISwitch!
    @IBOutlet weak var rangeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var averageVotesTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private let categories = ["English", "Spanish", "Korean"]

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter movies by categories"
        pickerView.delegate = self
        pickerView.dataSource = self
        languageTextField.inputView = pickerView
        setupTableView()
        setupTapGesture()
    }
    
    public init(presenter: FilterMoviePresenterInput) {
        self.presenter = presenter
        super.init(nibName: "FilterMovieViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        presenter.handleSearchButtonTapped(language: languageTextField.text ?? "English",
                                          forAdults: adultSwitch.isOn,
                                      operatorName: rangeSegmentedControl.selectedSegmentIndex,
                                            average: averageVotesTextField.text ?? "5")
    }
    
    // MARK: FilterMovieViewControllerProtocol
    
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
    
    // MARK: - Setup Tap Gesture
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension FilterMovieViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        categories[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        languageTextField.text = categories[row]
        languageTextField.resignFirstResponder()
    }
}

extension FilterMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        presenter.listOfMovies.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasicMovieTableViewCell.identifier, for: indexPath) as? BasicMovieTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(with: presenter.listOfMovies[indexPath.row])
        return cell
    }
}

