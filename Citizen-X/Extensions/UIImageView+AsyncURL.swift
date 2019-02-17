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
            
            // downsample to 300x300ish
            let newSize: CGSize
            
            if image.size.width >= image.size.height {
                let ratio = image.size.height / 300.0
                newSize = CGSize(width: image.size.width / ratio, height: 300.0)
            } else {
                let ratio = image.size.width / 300.0
                newSize = CGSize(width: 300.0, height: image.size.height / ratio)
            }
            
            let scaledImage = image.scaled(to: newSize)
            
            DispatchQueue.main.async() {
                UIImageView.imageCache[url.path] = scaledImage
                imageViewConfiguration(scaledImage, animated)
            }
        }.resume()
    }

    private static var imageCache: [String: UIImage] = [:]
    
}

extension UIImage {
    
    /// https://stackoverflow.com/questions/2658738/the-simplest-way-to-resize-an-uiimage
    func scaled(to size: CGSize) -> UIImage {
        let actualSize = CGSize(
            width: size.width / UIScreen.main.scale,
            height: size.height / UIScreen.main.scale)
        
        UIGraphicsBeginImageContextWithOptions(actualSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0.0, y: 0.0, width: actualSize.width, height: actualSize.height))
        
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
}
