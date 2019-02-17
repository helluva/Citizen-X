//
//  LegislatorViewContent.swift
//  Citizen-X
//
//  Created by Cliff Panos on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import UIKit
import CitizenKit

class LegislatorViewContent: NSObject, CardContentProviding {
    
    let legislators: [Legislator]
    var cachedCardContent: UIViewController?
    
    public init(legislators: [Legislator]) {
        self.legislators = legislators
    }
    
    func createCardContent() -> UIViewController {
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "LegislatorListViewController") as! LegislatorListViewController
        vc.legislators = self.legislators
        return vc
    }

}
