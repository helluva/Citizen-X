//
//  PersonalViewController.swift
//  Citizen-X
//
//  Created by Cliff Panos on 2/17/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController {
    
    // MARK: Presentation
    
    class func present(over presenter: UIViewController, with location: Location) {
        let navigationVC = UIStoryboard.main.instantiateViewController(withIdentifier: "PersonalViewControllerNavVC")
        navigationVC.modalPresentationStyle = .formSheet
        
        let personalVC = (navigationVC as! UINavigationController).viewControllers.first as! PersonalViewController
        personalVC.location = location
        presenter.present(navigationVC, animated: true, completion: nil)
    }
    
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Citizen X"
        locationLabel.text = "Political Location: \(location?.city ?? "Not Set")"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.roundCircularly()
    }
    
    
    // MARK: - Private
    
    @IBOutlet weak private var imageView: UIImageView!
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var locationLabel: UILabel!
    
    private var location: Location? = nil
    
}
