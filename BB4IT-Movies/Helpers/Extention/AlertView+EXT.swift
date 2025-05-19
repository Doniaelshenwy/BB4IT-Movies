//
//  AlertView+EXT.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import UIKit
import CDAlertView

extension UIViewController {
    func makeOkAlert(title: String, SubTitle: String = "", Image : UIImage = UIImage()) {
        let alert = CDAlertView(title: title, message: SubTitle, type: .notification)
        let doneAction = CDAlertViewAction(title: "Ok")
        alert.circleFillColor = .primary
        doneAction.buttonTextColor = .primary
        alert.add(action: doneAction)
        alert.show()
    }
}
