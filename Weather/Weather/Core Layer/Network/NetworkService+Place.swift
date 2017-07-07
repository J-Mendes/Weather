//
//  NetworkService+Place.swift
//  Weather
//
//  Created by Jorge Mendes on 07/07/2017.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

extension NetworkService {

    // MARK: - Place Requests
    
    internal func getPlace(latitude: Double, longitude: Double, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let urlString: String = String(format: NetworkConstants.Url.place, latitude, longitude).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        
        self.session.dataTask(with: URL(string: urlString)!) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                do {
                    let jsonResult: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
                    completion(jsonResult, nil)
                } catch let error {
                    print(error)
                    completion([:], nil)
                }
            } else {
                completion(nil, error)
            }
        }.resume()
    }
    
}
