//
//  LegislatorListViewController.swift
//  Citizen-X
//
//  Created by Cliff Panos on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import UIKit
import CitizenKit

class LegislatorListViewController: UIViewController {
    
    var legislators: [Legislator] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        for legislator in legislators {
            let summaryView = LegislatorSummaryView(frame: .zero, legislator: legislator)
            summaryView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(summaryView)
        }
    }
    
    @IBOutlet weak private var stackView: UIStackView!

}
