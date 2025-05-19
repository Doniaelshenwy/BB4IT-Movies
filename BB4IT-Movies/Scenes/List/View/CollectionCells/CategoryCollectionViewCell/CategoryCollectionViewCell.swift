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

    func configureCell(data: CategoriesModel) {
        categoryLabel.text = data.title
        selectedCategory(data.isSelected)
    }
    
    private func selectedCategory(_ status: Bool) {
        switch status {
        case true:
            categoryView.backgroundColor = .primary
            categoryLabel.textColor = .black
        default:
            categoryView.backgroundColor = .clear
            categoryLabel.textColor = .white
        }
    }
}
