//
//  EngagementViewController.swift
//  Citizen-X
//
//  Created by Cliff Panos on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import CitizenKit
import ModernUIKit
import CoreLocation

///
/// The primary view controller for speech interaction and displaying content cards
///
class EngagementViewController: UIViewController {
    
    let contentController = ContentController(for: .sanFrancisco)
    
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.contentController.delegate = self
        
        self.tableView.contentInset.bottom = 202    // sound hound view
        
        let locationImage = self.navigationItem.leftBarButtonItem!.image
        self.navigationItem.leftBarButtonItem!.image = locationImage?.withRenderingMode(.alwaysOriginal)
        
        self.navigationItem.rightBarButtonItem!.image = UIImage.appIconCoreVector30.withRenderingMode(.alwaysOriginal)
        
        if self.traitCollection.userInterfaceIdiom == .pad {
            self.tableView.tableHeaderView!.frame.size.height += 16
        }
    }

    
    // MARK: - Private
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var soundHoundView: UIView!
    
    @IBAction private func microphoneButtonTapped() {
        contentController.presentListeningViewController(in: self)
    }
    
    @IBAction private func setLocationButtonTapped() {
        SetLocationViewController.present(
            at: contentController.location,
            userLocation: .sanFrancisco,
            over: self,
            completion: { location in
                self.contentController.location = location
        })
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
        let interaction = contentController.interactions[contentController.interactions.count - indexPath.row - 1]
        
        let container: UIView! = cell.contentContainer
        container.translatesAutoresizingMaskIntoConstraints = false
        
        // Remove the old child view controller if necessary
        if let existingContent = cell.content {
            existingContent.willMove(toParent: nil)
            existingContent.view.removeFromSuperview()
            existingContent.removeFromParent()
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
            contentView.topAnchor.constraint(equalTo: container.topAnchor, constant: margin - 4.0),
            contentView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin + 4.0),
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        cell.content = content
        
        let query = interaction.queryText
        if query.count > 1 {
            cell.titleLabel.text = String(query.first!).capitalized + query.dropFirst() + "?"
        } else {
            cell.titleLabel.text = nil
        }
        
        return cell
    }
    
}

extension EngagementViewController: ContentControllerDelegate {
    
    func addedNewInteraction(_ interaction: CivicInteraction) {
        let lastIndexPath: IndexPath = .zero
        tableView.insertRows(at: [lastIndexPath], with: .fade)
    }
    
    func errorFetchingLegislators(_ error: Error) {
        presentAlert(
            "Couldn't fetch legislators for \(contentController.location.city)",
            message: error.localizedDescription)
    }
    
}
