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
    
    init() {
        print("init ViewModel")
        model = EntriesModel()
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
    
    func deleteEntryClicked(at offsets: IndexSet) {
        if let index = offsets.first {
            model.deleteEntry(index: index)
            // Save
            model.save()
            // Update View
            self.objectWillChange.send()
    
        }
    }
    
}
