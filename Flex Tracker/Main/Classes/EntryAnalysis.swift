//
//  EntryAnalysis.swift
//  Flex Tracker
//
//  Created by Archael dela Rosa on 4/27/23.
//

import Foundation


class EntryAnalysis {
    var entries: [Entry] = []
    // Hours Completed
    var hoursCompletedTotal: Double = 0
    var hoursCompletedAverage: Double = 0
    var hoursCompletedMin: Double = Double.greatestFiniteMagnitude
    var hoursCompletedMax: Double = 0
    // Milage
    var milageTotal: Double = 0
    var milageAverage: Double = 0
    var milageMin: Double = Double.greatestFiniteMagnitude
    var milageMax: Double = 0
    // Milage Return
    var milageReturnTotal: Double = 0
    var milageReturnAverage: Double = 0
    var milageReturnMin: Double = Double.greatestFiniteMagnitude
    var milageReturnMax: Double = 0
    // Routes
    var routes: [String] = []
    
    init() {}
    
    public func add(_ entry: Entry) {
        if !confirm(entry: entry) { return }
        entries.append(entry)
        parseHoursCompleted(entry.hoursCompleted)
        parseMilage(entry.milage)
        parseMilageReturn(entry.milageReturn)
        parseRoute(entry.routing)
    }
    
    func confirm(entry: Entry) -> Bool {
        // Confirm Entry is Completed
        return entry.isCompleted
    }
    
    func parseHoursCompleted(_ hours: Double) {
        hoursCompletedTotal += hours
        hoursCompletedMax = (hours > hoursCompletedMax) ? hours : hoursCompletedMax
        hoursCompletedMin = (hours < hoursCompletedMin) ? hours : hoursCompletedMin
        hoursCompletedAverage = hoursCompletedTotal / Double(entries.count)
    }
    
    func parseMilage(_ milage: Double) {
        milageTotal += milage
        milageMax = (milage > milageMax) ? milage : milageMax
        milageMin = (milage < milageMin) ? milage : milageMin
        milageAverage = milageTotal / Double(entries.count)
    }
    
    func parseMilageReturn(_ milage: Double) {
        milageReturnTotal += milage
        milageReturnMax = (milage > milageReturnMax) ? milage : milageReturnMax
        milageReturnMin = (milage < milageReturnMin) ? milage : milageReturnMin
        milageReturnAverage = milageReturnTotal / Double(entries.count)
    }
    
    func parseRoute(_ routing: String) {
        if !routes.contains(routing) {routes.append(routing)}
    }
    
    
    func toString() -> String {
        var string = "Entry Analysis:\n"
        string += "\t Hours Completed: Average: \(hoursCompletedAverage) (min:\(hoursCompletedMin), max:\(hoursCompletedMax)) \n"
        string += "\t Milage: Average: \(milageAverage) (min:\(milageMin), max:\(milageMax)) \n"
        string += "\t Milage Return: Average: \(milageReturnAverage) (min:\(milageReturnMin), max:\(milageReturnMax)) \n"
        string += "\t Routes: \(routes)\t"
        return string
    }
}
