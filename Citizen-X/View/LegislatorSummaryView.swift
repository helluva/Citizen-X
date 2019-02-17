//
//  LegislatorSummaryView.swift
//  Citizen-X
//
//  Created by Cliff Panos on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import UIKit
import CitizenKit

class LegislatorSummaryView: UIView {
    
    let stackView = UIStackView(frame: .zero)
    let nameLabel = UILabel(frame: .zero)
    let imageView = UIImageView(frame: .zero)

    internal init(frame: CGRect, legislator: Legislator) {
        super.init(frame: frame)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.backgroundColor = nil
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 4
        
        addSubview(stackView)
        addSubview(imageView)
        
        let imageViewDimension: CGFloat = 60
        imageView.backgroundColor = .lightGray
        imageView.cornerRadius = imageViewDimension / 2.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1.0 / UIScreen.main.scale
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -12),
            imageView.heightAnchor.constraint(equalToConstant: imageViewDimension),
            imageView.widthAnchor.constraint(equalToConstant: imageViewDimension),
        ])
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: imageViewDimension + 12)
        ])
        
        let nameLabel = UILabel(frame: .zero)
        nameLabel.text = legislator.name
        nameLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        nameLabel.numberOfLines = 1
        
        let officeLabel = UILabel(frame: .zero)
        officeLabel.text = legislator.office.displayString
        officeLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        officeLabel.numberOfLines = 1
        
        let partyLabel = UILabel(frame: .zero)
        partyLabel.text = " \(legislator.party.displayString) "
        partyLabel.textColor = .white
        partyLabel.backgroundColor = legislator.party.tintColor.brightened()
        partyLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        partyLabel.cornerRadius = 5.0
        partyLabel.layer.masksToBounds = true
        if legislator.party == .unknown { partyLabel.alpha = 0.0 }
        
        let namePartyStackView = UIStackView(arrangedSubviews: [nameLabel, partyLabel])
        namePartyStackView.axis = .horizontal
        namePartyStackView.spacing = 10.0
        namePartyStackView.alignment = .center
        namePartyStackView.distribution = .fill
        
        stackView.addArrangedSubview(namePartyStackView)
        stackView.addArrangedSubview(officeLabel)
        stackView.spacing = -8
        
        // GET THE IMAGE
        self.imageView.configureWithImage(for: legislator.imageURL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var legislator: Legislator!

}
