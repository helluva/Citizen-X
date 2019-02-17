//
//  GetStartedViewController.swift
//  Citizen-X
//
//  Created by Cliff Panos on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import UIKit

class GetStartedCardContent: CardContentProviding {
    
    var cachedCardContent: UIViewController?
    
    func createCardContent() -> UIViewController {
        return UIStoryboard.main.instantiateViewController(withIdentifier: "GetStartedViewController")
    }
    
    static let `default` = GetStartedCardContent()
    
    private init () { }
    
}

class GetStartedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
