//
//  OverlayView.swift
//  AR Planes
//
//  Created by Cal Stephens on 10/2/17.
//  Copyright © 2017 Hack the North. All rights reserved.
//

import UIKit

class OverlayView: UIView {
    
    let contentView = UIView()
    private let stackView = UIStackView()
    let label = UILabel()
    let loadingIndicator = UIActivityIndicatorView()
    
    init(text: String? = nil,
         showLoadingIndicator: Bool = false,
         textColor: UIColor = UIColor.black,
         font: UIFont = .systemFont(ofSize: 15),
         contentMargins: (left: CGFloat, right: CGFloat) = (20, 20))
    {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setUpContentView()
        setUpStackView(leftMargin: contentMargins.left, rightMargin: contentMargins.right)
        
        if showLoadingIndicator {
            setUpLoadingIndicator()
        }
        
        if let text = text {
            setUpLabel(text: text, color: textColor, font: font)
        }
        
        updateShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadow()
    }
    
    private func updateShadow() {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.15
        
        
        let cornerRadius = frame.height / 4
        contentView.layer.cornerRadius = cornerRadius
        
        layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: cornerRadius).cgPath
    }
    
    private func setUpContentView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = frame.height / 4
        contentView.layer.masksToBounds = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setUpStackView(leftMargin: CGFloat, rightMargin: CGFloat) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: leftMargin).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -rightMargin).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        stackView.alignment = .center
        stackView.spacing = 10
    }
    
    private func setUpLoadingIndicator() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.style = .gray
        loadingIndicator.startAnimating()
        loadingIndicator.setContentHuggingPriority(.required, for: .horizontal)
        stackView.addArrangedSubview(loadingIndicator)
    }
    
    private func setUpLabel(text: String, color: UIColor, font: UIFont) {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = color
        label.font = font
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        stackView.addArrangedSubview(label)
    }
    
    // MARK: Customization
    
    func addRightAccessory(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
    
    func addLeftAccessory(_ view: UIView) {
        stackView.insertArrangedSubview(view, at: 0)
    }
    
    var contentBackgroundColor: UIColor {
        get { return contentView.backgroundColor ?? .white }
        set { contentView.backgroundColor = contentBackgroundColor }
    }
    
    func setStackViewSpacing(_ spacing: CGFloat) {
        stackView.spacing = spacing
    }
    
}

extension UIView {
    
    // MARK: Animations
    
    func playAppearAnimation(matchingBounce: Bool = false) {
        guard alpha != 1.0 else { return }
        
        alpha = 0.0
        transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        UIView.animate(
            withDuration: matchingBounce ? 0.3 : 0.55,
            delay: 0.0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.0,
            options: [.allowUserInteraction],
            animations: {
                self.alpha = 1.0
                self.transform = .identity
        }, completion: nil)
    }
    
    func playDisappearAnimation(delay: TimeInterval = 0.0, then completion: @escaping () -> Void = {}) {
        guard alpha != 0.0 else { return }
        
        alpha = 1.0
        transform = .identity
        
        UIView.animate(
            withDuration: 0.2,
            delay: delay,
            options: [.curveEaseOut, .allowUserInteraction],
            animations: {
                self.alpha = 0.0
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }, completion: { _ in completion() })
    }
    
    func bounce() {
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: [.allowUserInteraction],
            animations: {
                self.transform = CGAffineTransform(scaleX: 1.07, y: 1.07)
        }, completion: nil)
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0.1,
            options: [.allowUserInteraction],
            animations: {
                self.transform = .identity
        }, completion: nil)
    }
    
}
