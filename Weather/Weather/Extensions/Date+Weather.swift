//
//  Date+Weather.swift
//  Weather
//
//  Created by Jorge Mendes on 06/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

extension Date {

    // MARK: - Validators
    
    internal func isToday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    internal func isTomorrow() -> Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    
    // MARK: - Converters
    
    internal func weekdayValue() -> String {
        return DateFormatter().weekdaySymbols[Calendar.current.component(.weekday, from: self) - 1].capitalized
    }
    
    internal func hourFormat() -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        return formatter.string(from: self)
    }
    
}
