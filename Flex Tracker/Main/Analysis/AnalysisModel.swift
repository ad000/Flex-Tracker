//
//  AnalysisModel.swift
//  Flex Tracker
//
//  Created by Archael dela Rosa on 4/26/23.
//

import Foundation
import CoreData

class AnalysisModel: ObservableObject {
    let context = PersistenceController.shared.container.viewContext
    
    @Published var analysis: EntryAnalysis
    
    init() {
        analysis = EntryAnalysis()
    }
    
    public func setAnalysis(_ hour: Double) {
        // Create New
        analysis = EntryAnalysis()
        // Fetch
        let entries: [Entry] = self.fetchEntriesBy(hour: hour)
        for entry in entries {
            analysis.add(entry)
        }
    }
    
    
    func fetchHourOptions() -> [Double] {
        // fetch options based on coreData
        var options: [Double] = []
        // Fetch Block
        let fetchRequest: NSFetchRequest<BlockEntity> = BlockEntity.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest) as [BlockEntity]
            print("FetchHourOptions:\tCore: BlockEntity fetched, count:", results.count)
            for block in results {
                if !options.contains(block.hours) {options.append(block.hours)}
            }
        }
        catch {
            debugPrint(error)
        }
        // Sort
        options = options.sorted(by: {($0) < ($1)})
        return options
    }
    
    
    private func fetchEntriesBy(hour: Double) -> [Entry] {
        var entries: [Entry] = []
        // Fetch Block
        var blocks: [BlockEntity] = []
        let fetchRequest: NSFetchRequest<BlockEntity> = BlockEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "hours == %f", hour) // Set Parameters
        do {
            let results = try context.fetch(fetchRequest) as [BlockEntity]
            print("\tCore: BlockEntity(Hour:\(hour)) fetched, count:", results.count)
            blocks = results
        }
        catch {
            debugPrint(error)
        }
        // For Each: Fetch Route Info
        for block in blocks {
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
        return entries
    }
    
}
