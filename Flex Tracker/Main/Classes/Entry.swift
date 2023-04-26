//
//  Entry.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/17/23.
//

import Foundation

// Object holding entry data
class Entry: ObservableObject {
    var id: UUID
    @Published var block: BlockEntity
    @Published var route: RouteEntity
    
    var date: String {
        get { return block.date! }
    }
    
    var timeStart: String {
        get { return block.timeStart!}
    }
    
    var timeEnd: String {
        get { return block.timeEnd!}
    }
    
    var hoursBlock: Double {
        get {
            // Get total Minutes
            let startHours = Double(timeStart.prefix(2))!
            let startMinutes = Double(timeStart.suffix(2))!
            let endHours = Double(timeEnd.prefix(2))!
            let endMinutes = Double(timeEnd.suffix(2))!
            // Convert Minutes to Hours
            let minutes = ((endHours * 60) + endMinutes) - ((startHours * 60) + startMinutes)
            let hours: Double = Double(minutes / 60)
            var span = round(hours * 100) / 100.0 // to 2 decimal places: 00.00
            // Check midnight roll over
            if (span < 0) {span = 24 + span}
            return span
        }
    }
    
    var pay: Double {
        get { return block.pay }
    }
    
    var routing: String {
        get { return route.route ?? ""}
    }
    
    var isCompleted: Bool {
        // Confirm all Route data has been filled
        get {
            return route.timeEnd != nil && (route.route != nil && route.route?.count ?? 0 > 0)
        }
    }
    
    
    init(block: BlockEntity, route: RouteEntity) {
        self.block = block
        self.route = route
        self.id = block.id!
    }
    
    func save() {
        let context = PersistenceController.shared.container.viewContext
        do {
            try context.save()
        }
        catch {
            // Handle Error
        }
    }
    
    
}
