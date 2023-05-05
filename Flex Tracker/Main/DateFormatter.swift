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
    
    public func getHoursFromTimeStrings(start: String, end: String) -> Double {
        // Get total Minutes
        let startHours = Double(start.prefix(2))!
        let startMinutes = Double(start.suffix(2))!
        let endHours = Double(end.prefix(2))!
        let endMinutes = Double(end.suffix(2))!
        // Convert Minutes to Hours
        let minutes = ((endHours * 60) + endMinutes) - ((startHours * 60) + startMinutes)
        let hours: Double = Double(minutes / 60)
        var span = round(hours * 100) / 100.0 // to 2 decimal places: 00.00
        // Check midnight roll over
        if (span < 0) {span = 24 + span}
        return span
    }
    
}
