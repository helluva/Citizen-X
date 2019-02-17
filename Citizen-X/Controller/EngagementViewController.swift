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
    
    let contentController = CivicInteractionsController(for: .sanFrancisco)
    
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.contentController.delegate = self
        
        self.tableView.contentInset.bottom = 130    // sound hound view
        
        let locationImage = self.navigationItem.leftBarButtonItem!.image
        self.navigationItem.leftBarButtonItem!.image = locationImage?.withRenderingMode(.alwaysOriginal)
        
        self.navigationItem.rightBarButtonItem!.image = UIImage.appIconCoreVector30.withRenderingMode(.alwaysOriginal)
        
        if self.traitCollection.userInterfaceIdiom == .pad {
            self.tableView.tableHeaderView!.frame.size.height += 16
        }
    }

    
    // MARK: - Private
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var microphoneButton: UIButton!
    
    @IBAction private func microphoneButtonTapped() {
        contentController.presentListeningViewController(in: self, from: microphoneButton)
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
        
        // Add the new content
        let content = interaction.responseContent
        let contentViewController = content.cardContent
        let contentView: UIView! = contentViewController.view
        self.addChild(contentViewController)
        contentView.frame = container.bounds
        container.addSubview(contentView)
        contentViewController.didMove(toParent: self)
        
        if !content.hasMargins {
            NSLayoutConstraint.activate([
                contentView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                contentView.topAnchor.constraint(equalTo: container.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            ])
        } else {
            let margin: CGFloat = 14
            NSLayoutConstraint.activate([
                contentView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin),
                contentView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin),
                contentView.topAnchor.constraint(equalTo: container.topAnchor, constant: margin - 4.0),
                contentView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin + 4.0),
            ])
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        cell.content = contentViewController
        
        if let query = interaction.queryText, query.count > 1 {
            cell.titleLabel.text = String(query.first!).capitalized + query.dropFirst()
        } else {
            cell.titleLabel.text = nil
        }
        
        if let shareableUrl = interaction.shareableUrl {
            cell.shareHandler = { shareButton in
                let shareString = "Get engaged with Citizen X!"
                let actionSheet = UIActivityViewController(activityItems: [shareString, shareableUrl], applicationActivities: nil)
                actionSheet.popoverPresentationController?.sourceView = shareButton
                actionSheet.popoverPresentationController?.sourceRect = shareButton.bounds
                actionSheet.popoverPresentationController?.permittedArrowDirections = [.up, .right]
                self.present(actionSheet, animated: true)
            }
        } else {
            cell.shareHandler = nil
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            if container.subviews.isEmpty {
                fatalError("something hath gone wrong")
            }
        })
        
        return cell
    }
    
}

extension EngagementViewController: CivicInteractionsControllerDelegate {
    
    func addedNewInteraction(_ interaction: CivicInteraction) {
        tableView.insertRows(at: [.zero], with: .fade)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
            self.tableView._scrollToTopIfPossible(true)
        })
    }
    
    func errorFetchingLegislators(_ error: Error) {
        presentAlert(
            "Couldn't fetch legislators for \(contentController.location.city)",
            message: error.localizedDescription)
    }
    
}
