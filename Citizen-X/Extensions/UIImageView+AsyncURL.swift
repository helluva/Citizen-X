//
//  UIImageView+AsyncURL.swift
//  Citizen-X
//
//  Created by Cliff Panos on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// Asynchronously set an imageView's image to be the contents of a URL for the given string
    func configureWithImage(from urlString: String, contentMode mode: UIView.ContentMode = .scaleAspectFill, animated: Bool = true) {
        guard let url = URL(string: urlString) else { return }
        configureWithImage(for: url, contentMode: mode, animated: animated)
    }
    
    /// Asynchronously set an imageView's image to be the contents of a URL
    func configureWithImage(for url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill, animated: Bool = true) {
        contentMode = mode
        
        let imageViewConfiguration: (_ image: UIImage, _ animated: Bool) -> Void = { [weak self](image, animated) in
            guard let self = self else { return }
            
            self.image = image
            self.layer.masksToBounds = true

            guard animated else { return }
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: .easeOut)
            transition.type = .fade
            self.layer.add(transition, forKey: nil)
        }
        
        if let cachedImage = UIImageView.imageCache[url.path] {
            imageViewConfiguration(cachedImage, false)
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, /*error == nil*/
                let image = UIImage(data: data) else {
                    print("Failed to download image for URL: \(url)")
                    return
                }
            DispatchQueue.main.async() {
                UIImageView.imageCache[url.path] = image
                imageViewConfiguration(image, animated)
            }
        }.resume()
    }

    private static var imageCache: [String: UIImage] = [:]

}
