//
//  Entry.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/17/23.
//

import Foundation

// Object holding entry data
class Entry: Identifiable, ObservableObject {
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
    
    var timeCompleted: String {
        get { return route.timeEnd!}
    }
    
    var hours: Double {
        get { return block.hours }
    }
    
    var hoursCompleted: Double {
        return Date().getHoursFromTimeStrings(start: timeStart, end: timeCompleted)
    }
    
    var pay: Double {
        get { return block.pay }
    }
    
    var routing: String {
        get { return route.route ?? ""}
    }
    
    var milage: Double {
        get { return route.milage }
    }
    
    var milageReturn: Double {
        get { return route.milageReturn }
    }
    
    var isCompleted: Bool {
        // Confirm all Route data has been filled
        get {
            return milage > 0 && milageReturn > 0 && route.timeEnd != nil && (route.route != nil && route.route?.count ?? 0 > 0)
        }
    }
    
    
    init(block: BlockEntity, route: RouteEntity) {
        self.block = block
        self.route = route
        self.id = block.id!
    }
    
    func update(routeName: String, end: Date, milage: Double, milageReturn: Double) {
        self.route.route = routeName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.route.timeEnd = end.toTimeString()
        self.route.milage = milage
        self.route.milageReturn = milageReturn
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
