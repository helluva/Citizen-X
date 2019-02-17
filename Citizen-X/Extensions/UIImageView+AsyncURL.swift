//
//  UIImageView+AsyncURL.swift
//  Citizen-X
//
//  Created by Cliff Panos on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func configureWithImage(for url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, /*error == nil*/
                let image = UIImage(data: data) else {
                    print("Failed to download image for URL: \(url)")
                    return
                }
            DispatchQueue.main.async() {
                self.image = image
                self.layer.masksToBounds = true
            }
        }.resume()
    }
    
    func configureWithImage(from urlString: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: urlString) else { return }
        configureWithImage(for: url, contentMode: mode)
    }

}
