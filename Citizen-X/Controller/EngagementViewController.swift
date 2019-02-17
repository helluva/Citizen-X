//
//  EngagementViewController.swift
//  Citizen-X
//
//  Created by Cliff Panos on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import CitizenKit
import ModernUIKit

///
/// The primary view controller for speech interaction and displaying content cards
///
class EngagementViewController: UIViewController {
    
    var contentProviders: [CardContentProviding] = []
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let promise = Phone2Action.fetchLegislators(for: "1151 S. Pennsylvania Avenue, Winter Park FL 32789")
        promise.then { (legislators) in
            let legislatorContent = LegislatorViewContent(legislators: legislators)
            self.contentProviders.insert(legislatorContent, at: 0)
            
            let insertionPath = IndexPath.zero
            self.tableView.insertRows(at: [insertionPath], with: .fade)
        }.catch { error in
            self.presentAlert("Legislators Unavailable", message: error.localizedDescription)
        }
    }

    
    // MARK: - Private
    
    @IBOutlet private weak var tableView: UITableView!

}


extension EngagementViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension EngagementViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentProviders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EngagementTableViewCell.reuseIdentifier, for: indexPath) as! EngagementTableViewCell
        let contentProvider = contentProviders[indexPath.row]
        
        let container: UIView! = cell.contentContainer
        container.translatesAutoresizingMaskIntoConstraints = false
        
        // Remove the old child view controller if necessary
        if let existingContent = cell.content {
            existingContent.willMove(toParent: nil)
            existingContent.view.removeFromSuperview()
            existingContent.removeFromParent()
            existingContent.view.removeConstraints(existingContent.view.constraints)
        }
        
        // Add the new content
        let content = contentProvider.cardContent
        let contentView: UIView! = content.view
        self.addChild(content)
        contentView.frame = container.bounds
        container.addSubview(contentView)
        content.didMove(toParent: self)
        
        let margin: CGFloat = 14
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin),
            contentView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin),
            contentView.topAnchor.constraint(equalTo: container.topAnchor, constant: margin),
            contentView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin),
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        cell.content = content
        
        return cell
    }
    
    
}
