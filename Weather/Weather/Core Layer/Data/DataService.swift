//
//  DataService.swift
//  Weather
//
//  Created by Jorge Mendes on 04/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

class DataService {

    internal var networkService: NetworkService!
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
}
