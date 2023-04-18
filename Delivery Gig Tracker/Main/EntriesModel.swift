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
        var blocks: [BlockEntity] = []
        // Fetch Block
        let fetchRequest: NSFetchRequest<BlockEntity> = BlockEntity.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest) as [BlockEntity]
            print("\tCore: BlockEntity fetched, count:", results.count)
            blocks = results
        }
        catch {
            debugPrint(error)
        }
        // For Each: Fetch Route Info
        for block in blocks {
            print("\(block.date!), \(block.timeStart!)")
            let fetchRequest: NSFetchRequest<RouteEntity> = RouteEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", block.id! as CVarArg) // Set Parameters
            do {
                let routes = try context.fetch(fetchRequest) as [RouteEntity]
                if routes.count == 0 { print("\(block.id!): \(block.date!): MISSING ROUTE ENTITY") }
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
            ($0.date, $0.timeStart) <
              ($1.date, $1.timeStart)
        })
    }
    
    func convertDateToDateString(date: Date) -> String {
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        // Set Date Format
        dateFormatter.dateFormat = "MM-dd"
        // Convert Date to String
        return dateFormatter.string(from: date)
    }
    
    func convertTimeToTimeString(time: Date) -> String {
        let calendar = Calendar.current
        // Get Time Components
        let hr = calendar.component(.hour, from: time)
        let hour: String = (hr<10) ? "0\(hr)" : String(hr)
        let min = calendar.component(.minute, from: time)
        let minutes: String = (min<10) ? "0\(min)" : String(min)
        return "\(hour):\(minutes)"
    }
    
    func createEntry(date: Date, start: Date, end: Date, pay: Double) -> Entry {
        // Create EntryInfo
        let block = BlockEntity(context: context)
        block.id = UUID()
        block.date = convertDateToDateString(date: date)
        block.timeStart = convertTimeToTimeString(time: start)
        block.timeEnd = convertTimeToTimeString(time:end)
        block.pay = pay
        // Create BlockInfo
        let route = RouteEntity(context: context)
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
