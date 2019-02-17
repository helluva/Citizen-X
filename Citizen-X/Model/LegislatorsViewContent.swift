//
//  LegislatorViewContent.swift
//  Citizen-X
//
//  Created by Cliff Panos on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import UIKit
import CitizenKit

class LegislatorsViewContent: NSObject, CardContentProviding {
    
    let legislators: [Legislator]
    var cachedCardContent: UIViewController?
    var cachedTableViewCell: UITableViewCell?
    
    public init(legislators: [Legislator]) {
        self.legislators = legislators
    }
    
    func createCardContent() -> UIViewController {
        let vc: UIViewController
        
        if legislators.count > 1 || legislators.count == 0 {
            vc = UIStoryboard.main.instantiateViewController(withIdentifier: "LegislatorListViewController")
            (vc as! LegislatorListViewController).legislators = self.legislators
        } else {
            vc = UIStoryboard.main.instantiateViewController(withIdentifier: "LegislatorDetailViewController")
            (vc as! LegislatorDetailViewController).legislator = self.legislators.first!
        }

        return vc
    }

}
