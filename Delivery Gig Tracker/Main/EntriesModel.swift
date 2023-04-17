//
//  EntriesModel.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/17/23.
//

import Foundation
import CoreData

class EntriesModel: ObservableObject {
    let context = PersistenceController.shared.container.viewContext
    
    @Published var entries: [Entry] = []
    
    init() {
        fetchAllEntries()
        // Sort
        sortEntries()
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
            print("\(block.date!), \(block.timeStart!)")
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
    
    func sortEntries() {
        // Sort by: Date > Time Start
        entries = entries.sorted(by: {
            (Int($0.date.timeIntervalSince1970), Int($0.timeStart.timeIntervalSince1970)) <
              (Int($1.date.timeIntervalSince1970), Int($1.timeStart.timeIntervalSince1970))
        })
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
        // Sort
        sortEntries()
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
}
