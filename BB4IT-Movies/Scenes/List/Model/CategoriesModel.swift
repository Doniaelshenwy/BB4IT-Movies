//
//  CategoriesModel.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import Foundation

class CategoriesModel {
    var title: String
    var keypath: String
    var isSelected: Bool
    
    init(title: String, isSelected: Bool = false, keypath: String) {
        self.title = title
        self.isSelected = isSelected
        self.keypath = keypath
    }
}
