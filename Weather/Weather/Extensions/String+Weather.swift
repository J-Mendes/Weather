//
//  String+Weather.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Converters
    
    internal func dateValueFromShortDate() -> Date? {
        return self.dateValue(dateFormat: "dd MMM yyyy")
    }
    
    internal func dateValueFromHour() -> Date? {
        return self.dateValue(dateFormat: "h:m a")
    }
    
    
    // MARK: - Private methods
    
    fileprivate func dateValue(dateFormat: String) -> Date? {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = dateFormat
        return formatter.date(from: self)
    }
    
}
