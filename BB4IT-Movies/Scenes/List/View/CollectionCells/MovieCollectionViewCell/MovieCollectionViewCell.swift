//
//  MovieCollectionViewCell.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(data: Movie?) {
        movieTitleLabel.text = data?.title ?? ""
        dateLabel.text = data?.releaseDate ?? ""
        movieImage.loadTMDbImage(from: "\(data?.posterPath ?? "")")
    }
}
