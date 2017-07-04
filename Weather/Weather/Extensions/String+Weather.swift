//
//  String+Weather.swift
//  Weather
//
//  Created by Jorge Mendes on 04/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

extension String {

    // MARK: Datetime Converters
    
    internal func shortDateValue() -> Date? {
        return self.dateValue(dateFormat: "HH MMM yyyy")
    }
    
    internal func longDateValue() -> Date? {
        return self.dateValue(dateFormat: "EEE, HH MMM yyyy hh:mm a zzz")
    }
    
    
    // MARK: Private methods
    
    fileprivate func dateValue(dateFormat: String) -> Date? {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = dateFormat
        return formatter.date(from: self)
    }
    
}
