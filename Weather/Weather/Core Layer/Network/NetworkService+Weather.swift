//
//  NetworkService+Weather.swift
//  Weather
//
//  Created by Jorge Mendes on 04/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

extension NetworkService {

    // MARK: - Weather Requests
    
    internal func getWeather(place: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let urlString: String = String(format: NetworkConstants.Url.weatherForecast, place)
        
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
