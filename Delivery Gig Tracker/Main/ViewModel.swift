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
    
    init() {
        fetchAllEntries()
    }
    
    func fetchAllEntries() {
        var blocks: [BlockInfo] = []
        // Fetch Block
        let fetchRequest: NSFetchRequest<BlockInfo> = BlockInfo.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest) as [BlockInfo]
            print("\tCore: BlockInfo fetched, count:", results.count)
            blocks = results
        }
        catch {
            debugPrint(error)
        }
        // For Each: Fetch Route Info
        for block in blocks {
            let fetchRequest: NSFetchRequest<RouteInfo> = RouteInfo.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", block.id! as CVarArg) // Set Parameters
            do {
                let routes = try context.fetch(fetchRequest) as [RouteInfo]
                if routes.count == 0 { print("\(block.id!): \(block.date!): MISSING ROUTEINFO") }
                else {
                    let route = routes[0]
                    // Create and Add Entry
                    let entry = Entry(block: block, route: route)
                    entries.append(entry)
                }
            }
            catch {
                debugPrint(error)
            }
        }
        
    }
    
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
    }
    
    func deleteEntry(entry: Entry) {
        // Remove From List
        if let index = entries.firstIndex(where: {$0.id == entry.id}) {
            entries.remove(at: index)
        }
        // Delete From CoreData
        context.delete(entry.block)
        context.delete(entry.route)
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
    var id: UUID
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
        self.id = block.id!
    }
    
}
