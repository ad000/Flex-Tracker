//
//  EntryAnalysis.swift
//  Flex Tracker
//
//  Created by Archael dela Rosa on 4/27/23.
//

import Foundation


class EntryAnalysis: ObservableObject {
    @Published var entries: [Entry] = []
    // Hours Completed
    @Published var hoursCompletedTotal: Double = 0
    @Published var hoursCompletedAverage: Double = 0
    @Published var hoursCompletedMin: Double = Double.greatestFiniteMagnitude
    @Published var hoursCompletedMax: Double = 0
    // Milage
    @Published var milageTotal: Double = 0
    @Published var milageAverage: Double = 0
    @Published var milageMin: Double = Double.greatestFiniteMagnitude
    @Published var milageMax: Double = 0
    // Milage Return
    @Published var milageReturnTotal: Double = 0
    @Published var milageReturnAverage: Double = 0
    @Published var milageReturnMin: Double = Double.greatestFiniteMagnitude
    @Published var milageReturnMax: Double = 0
    // Routes
    @Published var routes = [String: Int]()
    
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
        let routeString = routing.trimmingCharacters(in: .whitespacesAndNewlines) // trim excess spacing
        if let _ = routes[routeString] {
            routes[routeString]! += 1
        } else {
            routes[routeString] = 1
        }
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
