//
//  UIImageView+EXT.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import UIKit
import SDWebImage

extension UIImageView {
    private var setupLoader: UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        
        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        activityIndicatorView.startAnimating()
        activityIndicatorView.color = .primary
        activityIndicatorView.isHidden = false
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }
    
    func loadTMDbImage(from stringURL: String?, _ placeholder: UIImage? = .init(named: "logo")) {
        guard let stringURL,
              let url = URL(string: "https://image.tmdb.org/t/p/w500/\(stringURL)") else {
            self.image = placeholder
            return
        }
        
        let activityIndicatorView = setupLoader
        let options: SDWebImageOptions = [.continueInBackground]
        
        self.sd_setImage(with: url, placeholderImage: placeholder, options: options) { [weak self] image, error, cache, url in
            guard let self else { return }
            activityIndicatorView.removeFromSuperview()
            self.image = image
        }
    }
}
