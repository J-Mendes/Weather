//
//  Constants.swift
//  Weather
//
//  Created by Jorge Mendes on 06/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

class Constants {
    
    internal enum UnitsType: Int {
        case Imperial = 1, Metric
    }

    struct UserDefaultsKeys {
        static let location: String = "location"
        static let units: String = "units"
    }

    struct DefaultValues {
        static let defaultLocation: String = "Lisbon, PT"
        static let defaultUnit: Int = UnitsType.Metric.rawValue
    }
    
}
