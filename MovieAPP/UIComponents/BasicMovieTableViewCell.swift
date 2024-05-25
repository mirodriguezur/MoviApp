//
//  BasicMovieTableViewCell.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 25/05/24.
//

import UIKit

class BasicMovieTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func register() -> UINib {
        UINib(nibName: "BasicMovieTableViewCell", bundle: nil)
    }
    
    static var identifier: String {
        get {
            "BasicMovieTableViewCell"
        }
    }
    
    func setupCell(with movie: GeneralMovieEntity) {
        // TODO: Setup image.
        self.titleLabel.text = movie.title
        self.descriptionLabel.text = movie.overview
        self.scoreLabel.text = String(movie.votes)
    }
}
