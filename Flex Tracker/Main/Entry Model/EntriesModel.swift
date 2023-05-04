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
    
    @Published var entryList: EntryList
    var totalEntryCount: Int = 0
    var currentOffet: Int = 0
    let FETCHCOUNT = 12
    
    init(test: Bool = false) {
        self.entryList = EntryList()
        fetchTotalEntryCount()
        if (!test) {_ = loadMoreEntries()}
    }
    
    func loadMoreEntries() -> Bool {
        // Return Bool: Can Load More
        if (currentOffet >= totalEntryCount) {
            print("ENTRIES AT MAX", totalEntryCount)
            return false
        }
        // Fetch More
        let entries = fetchEntries(count: FETCHCOUNT, offset: currentOffet)
        // Add to List
        for entry in entries {
            entryList.add(entry: entry)
        }
        // Update Offset
        currentOffet += FETCHCOUNT
        return currentOffet < totalEntryCount
    }
    
    func fetchTotalEntryCount() {
        let userFetchRequest = NSFetchRequest<NSNumber>(entityName: "BlockEntity")
        userFetchRequest.resultType = .countResultType
        do {
            let counts: [NSNumber] = try! context.fetch(userFetchRequest)
            totalEntryCount = counts[0] as! Int
            print("Total Entries in Core Data:", totalEntryCount)
        }
    }
    
    func checkEntryExists(date: Date, time: Date) -> Bool {
        // convert Dates to associated Strings
        let dateString = date.toDateString()
        let timeString = time.toTimeString()
        print("checkEntryExists", dateString, timeString)
        // Fetch
        let fetchRequest: NSFetchRequest<BlockEntity> = BlockEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@ AND timeStart == %@", dateString, timeString)
        do {
            let count = try context.count(for: fetchRequest)
            if count  == 0 {return false}
        } catch {
            print("Error: \(error)")
        }
        return true // Default to Existing
    }
    
    private func fetchBlocks(sortParameter: [String] = [], limitCount: Int? = nil, offsetIndex: Int? = nil) -> [BlockEntity] {
        var blocks: [BlockEntity] = []
        // fetch
        let request: NSFetchRequest<BlockEntity> = BlockEntity.fetchRequest()
        if (limitCount != nil) {request.fetchLimit = limitCount!}
        if (offsetIndex != nil) {request.fetchOffset = offsetIndex!}
        // Sorting
        var sortingParameters: [NSSortDescriptor] = []
        for parameter in sortParameter {
            sortingParameters.append( NSSortDescriptor(key: parameter, ascending: false) )
        }
        if (sortingParameters.count > 0) {
            request.sortDescriptors = sortingParameters
        }
        do {
            blocks = try context.fetch(request)
            // print("\tCore: BlockEntity fetched, count:", results.count)
        } catch { debugPrint(error) }
        return blocks
    }
    
    private func fetchRoute(id: UUID) -> RouteEntity? {
        let fetchRequest: NSFetchRequest<RouteEntity> = RouteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg) // Set Parameters
        do {
            let routes = try context.fetch(fetchRequest) as [RouteEntity]
            if routes.count == 0 { print("\(id): MISSING ROUTE ENTITY") }
            else {
                return routes[0]
            }
        }
        catch {  debugPrint(error) }
        return nil
    }
    
    func fetchEntries(count: Int, offset: Int) -> [Entry] {
        var list: [Entry] = []
        // Fetch portion of Entries based on starting index and count
        let blocks = fetchBlocks(sortParameter: ["date", "timeStart"], limitCount: count, offsetIndex: offset)
        // Fetch Matching Route Info
        for block in blocks {
            if let route = fetchRoute(id: block.id!) {
                // Create and Add Entry
                let entry = Entry(block: block, route: route)
                list.append(entry)
            }
        }
        return list
    }
    
    func fetchAllEntries() {
        // Fetch Blocks
        let blocks: [BlockEntity] = fetchBlocks()
        // Fetch Matching Route Info
        for block in blocks {
            if let route = fetchRoute(id: block.id!) {
                // Create and Add Entry
                let entry = Entry(block: block, route: route)
                entryList.add(entry: entry)
            }
        }
    }
    
    func deleteAllData() {
        // Local Data
        entryList.removeAll()
        // Core Data
        let fetchRequest: NSFetchRequest<BlockEntity> = BlockEntity.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest) as [BlockEntity]
            print("\tCore: BlockEntity fetched, count:", results.count)
            for block in results {
                context.delete(block)
            }
        }
        catch {
            debugPrint(error)
        }
        
        let fetchRequest2: NSFetchRequest<RouteEntity> = RouteEntity.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest2) as [RouteEntity]
            print("\tCore: RouteEntity fetched, count:", results.count)
            for route in results {
                context.delete(route)
            }
        }
        catch {
            debugPrint(error)
        }
    }
    
    func createEntry(date: Date, start: Date, end: Date, pay: Double) -> Entry {
        // Create EntryInfo
        let block = BlockEntity(context: context)
        block.id = UUID()
        block.date = date.toDateString()
        block.timeStart = start.toTimeString()
        block.timeEnd = end.toTimeString()
        block.hours = Date().getHoursFromTimeStrings(start: block.timeStart!, end: block.timeEnd!)
        block.pay = pay
        // Create BlockInfo
        let route = RouteEntity(context: context)
        route.id = block.id
        // Create Entry Object
        let entry = Entry(block: block, route: route)
        totalEntryCount += 1
        // return
        return entry
    }
    
    
    func deleteEntry(index: Int) {
        // Remove From List
        if let entry = entryList.remove(index: index) {
            // Update Count
            totalEntryCount -= 1
            // Delete From CoreData
            context.delete(entry.block)
            context.delete(entry.route)
            print("REMOVED: \(entry.id) : \(entry.date)")
        } else {
            print("deleteEntry: Cant find index \(index) to delete")
        }
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
