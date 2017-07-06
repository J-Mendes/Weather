//
//  UIImageView+Weather.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // MARK: - Async load image
    
    internal func loadImageFrom(link: String, placeholder: String? = nil) {
        if placeholder != nil {
            DispatchQueue.main.async() { () -> Void in
                self.image = UIImage(named: placeholder!)
            }
        }
        
        NetworkService().getImage(link: link) { (image: UIImage?, error: Error?) in
            if error == nil && image != nil {
                DispatchQueue.main.async() { () -> Void in
                    self.image = image
                }
            }
        }
    }
    
    internal func cancelLoadImageFrom(link: String) {
        NetworkService().cancelRequests(url: link)
    }
    
}
