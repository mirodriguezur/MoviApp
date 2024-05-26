//
//  FilterMovieViewController.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import UIKit

class FilterMovieViewController: UIViewController {
    
    @IBOutlet weak var languageTextField: UITextField!
    private let presenter: FilterMoviePresenterInput
    private let pickerView = UIPickerView()
    
    private let categories = ["English", "Spanish", "Korean"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter movies by categories"
        pickerView.delegate = self
        pickerView.dataSource = self
        languageTextField.inputView = pickerView
    }
    
    init(presenter: FilterMoviePresenterInput) {
        self.presenter = presenter
        super.init(nibName: "FilterMovieViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not een implemented")
    }

}

extension FilterMovieViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        languageTextField.text = categories[row]
        languageTextField.resignFirstResponder()
    }
    
}
