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
        
        if legislators.isEmpty {
            let noDataLabel = UILabel(frame: .zero)
            noDataLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
            noDataLabel.text = "No Data Available"
            noDataLabel.textAlignment = .center
            
            let empty = UILabel(frame: .zero)
            empty.font = UIFont.systemFont(ofSize: 6.0)
            empty.text = "    "
            let empty2 = UILabel(frame: .zero)
            empty2.font = empty.font
            empty2.text = empty.text
            stackView.addArrangedSubview(empty)
            stackView.addArrangedSubview(noDataLabel)
            stackView.addArrangedSubview(empty2)
        }
    }
    
    @IBOutlet weak private var stackView: UIStackView!

}
