//
//  NetworkService.swift
//  Weather
//
//  Created by Jorge Mendes on 04/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

class NetworkService {

    internal var session: URLSession!
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    deinit {
        self.session = nil
    }
    
    internal func cancelRequests(url: String, completion: (() -> Void)? = nil) {
        self.session.getAllTasks { (tasks: [URLSessionTask]) in
            tasks.forEach {
                if let link: String = $0.originalRequest?.url?.absoluteString,
                    link == url {
                    $0.cancel()
                }
            }
            
            if completion != nil {
                completion!()
            }
        }
    }
    
    internal func cancelAllRequests(completion: (() -> Void)? = nil) {
        self.session.getAllTasks { (tasks: [URLSessionTask]) in
            tasks.forEach {
                $0.cancel()
            }
            
            if completion != nil {
                completion!()
            }
        }
    }
    
}
