//
//  UIImageView+EXT.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadTMDbImage(from posterPath: String?, size: String = "w500") {
        guard let posterPath = posterPath else {
            print("Poster path is nil")
            return
        }
        let imageUrlString = "https://image.tmdb.org/t/p/\(size)\(posterPath)"
        print("Loading image from URL: \(imageUrlString)")
        guard let imageUrl = URL(string: imageUrlString) else {
            print("Invalid image URL")
            return
        }

        self.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "logo")) { image, error, _, _ in
            if let error = error {
                print("Failed to load image with SDWebImage: \(error.localizedDescription)")
            } else {
                print("Image loaded successfully")
            }
        }
    }
}
