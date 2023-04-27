//
//  EntriesModel-Analysis.swift
//  Flex Tracker
//
//  Created by Archael dela Rosa on 4/26/23.
//

import Foundation
import CoreData


extension EntriesModel {
    
    func getHourAnalysis(_ hour: Double) -> EntryAnalysis {
        let analysis = EntryAnalysis()
        // Fetch (COMPLETED) Entries with matching Hours
        let entries: [Entry] = self.fetchEntriesBy(hour: hour)
        for entry in entries {
            analysis.add(entry)
        }
        return analysis
    }
    
    
    fileprivate func fetchEntriesBy(hour: Double) -> [Entry] {
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
