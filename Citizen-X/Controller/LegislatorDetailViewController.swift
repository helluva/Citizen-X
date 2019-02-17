//
//  LegislatorDetailViewController.swift
//  Citizen-X
//
//  Created by Cliff Panos on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import UIKit
import CitizenKit

class LegislatorDetailViewController: UIViewController {
    
    internal var legislator: Legislator!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let summaryView = LegislatorSummaryView(frame: .zero, legislator: legislator)
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        summaryContainerView.addSubview(summaryView)
        NSLayoutConstraint.activate([
            summaryContainerView.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor),
            summaryContainerView.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor),
            summaryContainerView.topAnchor.constraint(equalTo: summaryView.topAnchor),
            summaryContainerView.bottomAnchor.constraint(equalTo: summaryView.bottomAnchor),
        ])
        
        // Configure detail labels
        officeLocationLabel.text = "Office in \(legislator.officeLocation)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        let startString = dateFormatter.string(from: legislator.termStart)
        var dateString = "Term started on \(startString)"
        if let endDate = legislator.termEnd {
            dateString += "\nTerm ends on \(dateFormatter.string(from: endDate))"
        }
        termDatesLabel.text = dateString
        
        // Configure the websites (+ non social media social services)
        let addWebsiteButtonBlock: (_ title: String, _ websiteURL: URL) -> Void = { title, websiteURL in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.applicationPrimary2, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
            self.websitesStackView.addArrangedSubview(button)
        }
        
        if let website = legislator.website {
            addWebsiteButtonBlock("Website", website)
        }
        
        // Configure the socials
        let addSocialButtonBlock: (_ iconImage: UIImage, _ websiteURL: URL) -> Void = { image, websiteURL in
            let button = UIButton(type: .system)
            button.tintColor = .applicationSecondary
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            button.imageView!.tintColor = .applicationSecondary
            self.socialsStackView.addArrangedSubview(button)
        }
        
        legislator.socialServices.forEach { (service) in
            print("Adding social service: \(service.displayString)")
            if service.isSocialMedia {
                addSocialButtonBlock(UIImage(named: service.displayString)!, service.websiteURL)
            } else {
                addWebsiteButtonBlock(service.displayString, service.websiteURL)
            }
        }

    }
    

    // MARK: - Private
    
    @IBOutlet weak private var summaryContainerView: UIView!
    
    @IBOutlet weak private var officeLocationLabel: UILabel!
    @IBOutlet weak private var termDatesLabel: UILabel!
    
    @IBOutlet weak private var websitesStackView: UIStackView!
    @IBOutlet weak private var socialsStackView: UIStackView!

}
