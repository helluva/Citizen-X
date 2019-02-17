//
//  LocationViewContent.swift
//  Citizen-X
//
//  Created by Cal Stephens on 2/17/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import Foundation
import UIKit

class LocationViewContent: NSObject, CardContentProviding {
    
    let location: Location
    var cachedCardContent: UIViewController?
    
    var hasMargins: Bool {
        return false
    }
    
    public init(location: Location) {
        self.location = location
    }
    
    func createCardContent() -> UIViewController {
        return SimpleLocationViewController(for: location)
    }
    
}
