//
//  CategoryCollectionViewCell.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var categoryView: UIView!
    @IBOutlet private weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureGenreCell(data: GenreResponse?) {
        categoryLabel.text = data?.name ?? ""
        categoryView.backgroundColor = .blackBG
    }

    func configureCell(data: CategoriesModel) {
        categoryLabel.text = data.title
        selectedCategory(data.isSelected)
    }
    
    private func selectedCategory(_ status: Bool) {
        categoryView.backgroundColor = status ? .primary : .clear
        categoryLabel.textColor = status ? .black : .white
    }
}
