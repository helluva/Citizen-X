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
            let summaryView = LegislatorSummaryView(frame: .zero)
            summaryView.translatesAutoresizingMaskIntoConstraints = false
            summaryView.legislator = legislator
            stackView.addArrangedSubview(summaryView)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak private var stackView: UIStackView!

}
