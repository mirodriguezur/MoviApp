//
//  DetailMovieViewController.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 26/05/24.
//

import UIKit

class DetailMovieViewController: UIViewController {
    
    private var movie: GeneralMovieEntity
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    
    init(movie: GeneralMovieEntity) {
        self.movie = movie
        super.init(nibName: "DetailMovieViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.titleLabel.text = movie.title
        self.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w200" + movie.imageURL))
        self.descriptionLabel.text = movie.overview
        self.votesLabel.text = String(movie.votes)
        self.languageLabel.text = movie.language
    }
}
