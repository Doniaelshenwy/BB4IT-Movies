//
//  BaseViewController.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import UIKit

class BaseViewController: UIViewController {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.frame = .init(x: 0, y: 0, width: 80, height: 80)
        indicator.color = .primary
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var cancellable = Cancellable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.setNeedsLayout()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    func startLoading() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
}

private extension BaseViewController {
    
    func setUpNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        
        let backItemAppearance = UIBarButtonItemAppearance()
        backItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance = backItemAppearance
        appearance.setBackIndicatorImage(.arrowLeft, transitionMaskImage: .arrowLeft)
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.setNeedsLayout()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
