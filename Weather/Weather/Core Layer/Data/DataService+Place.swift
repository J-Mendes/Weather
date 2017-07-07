//
//  DataService+Place.swift
//  Weather
//
//  Created by Jorge Mendes on 07/07/2017.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

extension DataService {

    // MARK: - Place Data
 
    internal func getPlace(latitude: Double, longitude: Double, completion: @escaping (String?, Error?) -> Void) {
        self.networkService.getPlace(latitude: latitude, longitude: longitude) { (data: [String : Any]?, error: Error?) in
            if error == nil && data != nil {
                if let query: [String: Any] = data!["query"] as? [String: Any],
                    let results: [String: Any] = query["results"] as? [String: Any],
                    let place: [String: Any] = results["place"] as? [String: Any] {
                    var result: String = ""
                    
                    if let admin2: String = place["admin2"] as? String {
                        result += admin2
                    }
                    
                    if let admin1: String = place["admin1"] as? String {
                        if !result.isEmpty {
                            result += ", "
                        }
                        result += admin1
                    }
                    
                    if let country: [String: Any] = place["country"] as? [String: Any],
                        let code: String = country["code"] as? String {
                        if !result.isEmpty {
                            result += ", "
                        }
                        result += code
                    }
                    
                    DispatchQueue.main.async {
                        if !result.isEmpty {
                            completion(result, nil)
                        } else {
                            completion(nil, nil)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil, nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
    
}
