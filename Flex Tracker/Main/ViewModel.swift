//
//  ViewModel.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/14/23.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject {
    @Published var model: EntriesModel
    @Published var canLoadMore: Bool = true
    
    var entries: [Entry] {
        get {return model.entryList.entries}
    }
    
    var entriesByCurrentDate: [String: [Entry]] {
        let currentDateString = Date().toDateString()
        return Dictionary(grouping: model.entryList.entries, by: { ($0.date == currentDateString && !$0.isCompleted) ? "Today" : "Routes" })
    }
    
    init() {
        print("init ViewModel")
        model = EntriesModel()
        canLoadMore = model.loadMoreEntries() // Load init entries and update bool
    }
    
    func updateView() {
        // Update View
        self.objectWillChange.send()
    }
    
    func LoadMoreEntries() {
        self.canLoadMore = model.loadMoreEntries()
        print("\(model.entryList.count)/\(model.totalEntryCount)", canLoadMore)
        // Update View
        self.objectWillChange.send()
    }
    
    func addEntryClicked(date: Date, start: Date, end: Date, pay: Double) {
        // Create Entry
        let entry = model.createEntry(date: date, start: start, end: end, pay: pay)
        // Add
        model.entryList.add(entry: entry)
        // Save
        model.save()
        // Update View
        self.objectWillChange.send()
    }
    
    func deleteCurrentlyActiveEntryClicked(at offsets: IndexSet) {
        if let index = offsets.first {
            let entry = entriesByCurrentDate["Today"]![index]
            model.deleteEntry(id: entry.id)
            // Save
            model.save()
            // Update View
            self.objectWillChange.send()
        }
    }
    
    func deleteEntryClicked(at offsets: IndexSet) {
        if let index = offsets.first {
            let entry = entriesByCurrentDate["Routes"]![index]
            model.deleteEntry(id: entry.id)
            // Save
            model.save()
            // Update View
            self.objectWillChange.send()
            
        }
    }
    
}
