//
//  NetworkService+UIImage.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import UIKit

extension NetworkService {

    // MARK: - UIImage Requests
    
    internal func getImage(link: String, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        guard let url: URL = URL(string: link) else {
            completion(nil, nil)
            return
        }
        
        self.session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    data != nil, let image = UIImage(data: data!) {
                    completion(image, nil)
                } else {
                    completion(nil, nil)
                }
            } else {
                completion(nil, error)
            }
        }.resume()
    }
    
}
