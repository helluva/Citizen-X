//
//  WebsiteButton.swift
//  Citizen-X
//
//  Created by Cliff Panos on 2/17/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import UIKit

class WebsiteButton: UIButton {
    
    init(websiteURL: URL) {
        self.websiteURL = websiteURL
        super.init(frame: .zero)
    }
    
    override var buttonType: UIButton.ButtonType {
        return .system
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal let websiteURL: URL
    
}
