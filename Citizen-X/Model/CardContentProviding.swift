//
//  CardContentProviding.swift
//  Citizen-X
//
//  Created by Cliff Panos on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import UIKit

protocol CardContentProviding: class {
    
    var cachedCardContent: UIViewController? { get set }
    var cardContent: UIViewController { get }
    var hasMargins: Bool { get }

    func createCardContent() -> UIViewController
    
}

extension CardContentProviding {
    
    var cardContent: UIViewController {
        if let cached = cachedCardContent {
            return cached
        }
        let vc = createCardContent()
        cachedCardContent = vc
        return vc
    }
    
    var hasMargins: Bool {
        return true
    }
    
}
