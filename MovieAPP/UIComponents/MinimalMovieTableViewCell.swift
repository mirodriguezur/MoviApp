//
//  MinimalMovieTableViewCell.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 27/05/24.
//

import UIKit
import Kingfisher

public final class MinimalMovieTableViewCell: UITableViewCell {

    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular, width: .condensed)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let voteAverage: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular, width: .standard)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Title:"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let votesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Votes:"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    static var identifier: String {
        get {
            "MinimalTableViewCell"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(movieImageView)
        addSubview(titleLabel)
        addSubview(movieTitle)
        addSubview(votesLabel)
        addSubview(voteAverage)
        
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            movieImageView.heightAnchor.constraint(equalToConstant: 110),
            movieImageView.widthAnchor.constraint(equalToConstant: 90),
            movieImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10),
            
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 5),
            titleLabel.widthAnchor.constraint(equalToConstant: 78),
            
            votesLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 5),
            votesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 52),
            votesLabel.widthAnchor.constraint(equalToConstant: 78),

            movieTitle.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            movieTitle.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 5),
                    
            voteAverage.leadingAnchor.constraint(equalTo: votesLabel.trailingAnchor, constant: 8),
            voteAverage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            voteAverage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 52),
            voteAverage.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -12)
        ])
    }
    
    func setupCell(with movie: GeneralMovieEntity) {
        self.movieImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w200" + movie.imageURL))
        self.movieTitle.text = movie.title
        self.voteAverage.text = String(movie.votes)
    }

}
