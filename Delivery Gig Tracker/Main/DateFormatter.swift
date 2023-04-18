//
//  DateFormatter.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/18/23.
//

import Foundation


extension Date {
    
    var dateStringFormat: String {
        get {return "MM-dd"}
    }
    
    var timeStringFormat: String {
        get {return "HH:mm"}
    }
    
    
    
    public func toDateString() -> String {
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        // Set Date Format
        dateFormatter.dateFormat = self.dateStringFormat
        // Convert Date to String
        return dateFormatter.string(from: self)
    }
    
    public func toTimeString() -> String {
        let calendar = Calendar.current
        // Get Time Components
        let hr = calendar.component(.hour, from: self)
        let hour: String = (hr<10) ? "0\(hr)" : String(hr)
        let min = calendar.component(.minute, from: self)
        let minutes: String = (min<10) ? "0\(min)" : String(min)
        return "\(hour):\(minutes)"
    }
    
    public func dateStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        // Date to DateString
        dateFormatter.dateFormat = self.dateStringFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.date(from: dateString)
        return date
    }
    
    public func timeStringToDate(timeString: String) -> Date? {
        let dateFormatter = DateFormatter()
        // Date to DateString
        dateFormatter.dateFormat = self.timeStringFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.date(from: timeString)
        return date
    }
    
}
