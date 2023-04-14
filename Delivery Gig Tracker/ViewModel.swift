//
//  ViewModel.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/14/23.
//

import Foundation
import CoreData

class ViewModel: ObservableObject {
    let context = PersistenceController.shared.container.viewContext
    var entries: [Entry] = []
    
    func createEntry(date: Date, start: Date, end: Date, pay: Double) -> Entry {
        // Create EntryInfo
        let block = BlockInfo(context: context)
        block.id = UUID()
        block.date = date
        block.timeStart = start
        block.timeEnd = end
        block.pay = pay
        // Create BlockInfo
        let route = RouteInfo(context: context)
        route.id = block.id
        // Create Entry Object
        let entry = Entry(block: block, route: route)
        // return
        return entry
    }
    
    func addEntry(entry: Entry) {
        // Add to List
        entries.append(entry)
        // Save Object to Core Data
        save()
    }
    
    func save() {
        // Save
        do {
            try context.save()
        }
        catch {
            // Handle Error
        }
    }
    
    
    // UI INTERACTIONS
    
    func addEntryClicked() {
        // Display Add Entry Pop Up
    }
    
}



// Object holding entry data
class Entry: ObservableObject {
    var block: BlockInfo
    var route: RouteInfo
    
    var date: Date {
        get { return block.date! }
    }
    
    var timeStart: Date {
        get { return block.timeStart!}
    }
    
    var timeEnd: Date {
        get { return block.timeEnd!}
    }
    
    var pay: Double {
        get { return block.pay }
    }
    
    
    init(block: BlockInfo, route: RouteInfo) {
        self.block = block
        self.route = route
    }
    
}
