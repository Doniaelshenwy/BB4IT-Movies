//
//  UIVIewController+EXT.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import UIKit

extension UIViewController {
    func push(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func isNavigationHidden(_ status: Bool) {
        navigationController?.isNavigationBarHidden = status
    }
}


