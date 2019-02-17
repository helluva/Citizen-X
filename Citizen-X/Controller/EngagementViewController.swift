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
    
    let contentController = ContentController(for: "Palo Alto, CA")
    
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.contentController.delegate = self
    }

    
    // MARK: - Private
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBAction private func microphoneButtonTapped() {
        contentController.presentListeningViewController(in: self)
    }

}


extension EngagementViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension EngagementViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentController.interactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EngagementTableViewCell.reuseIdentifier, for: indexPath) as! EngagementTableViewCell
        let interaction = contentController.interactions[indexPath.row]
        
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
        let content = interaction.responseContent.cardContent
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
        cell.titleLabel.text = interaction.queryText
        
        return cell
    }
    
}

extension EngagementViewController: ContentControllerDelegate {
    
    func addedNewInteraction(_ interaction: Interaction) {
        let lastIndexPath = IndexPath(row: contentController.interactions.count - 1, section: 0)
        tableView.insertRows(at: [lastIndexPath], with: .fade)
    }
    
}
