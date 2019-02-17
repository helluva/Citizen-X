//
//  EngagementTableViewCell.swift
//  Citizen-X
//
//  Created by Cliff Panos on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import ModernUIKit

class EngagementTableViewCell: UITableViewCell {
    
    public static let reuseIdentifier = "EngagementCell"
    
    public var content: UIViewController? = nil
    

    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()

        contentContainer.smoothCornerRadius = 12
        contentContainer.smoothBackgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - UIView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentContainer.shadow()
        self.contentContainer.layer.shadowOpacity = 0.225
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
    }
    
    
    // MARK: - Internal
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentContainer: ModernContinuousContourView!
    @IBOutlet weak var shareButton: UIButton!
    
    var shareHandler: ((UIView) -> Void)? {
        didSet {
            shareButton.isHidden = (shareHandler == nil)
        }
    }
    
    @IBAction func shareButtonTapped() {
        shareHandler?(shareButton)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        if let existingContent = content,
            existingContent.view.superview == contentContainer
        {
            existingContent.willMove(toParent: nil)
            existingContent.view.removeFromSuperview()
            existingContent.removeFromParent()
        }
    }
    
}
