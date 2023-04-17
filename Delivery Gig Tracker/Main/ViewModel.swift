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
    
    init() {
        print("init ViewModel")
        model = EntriesModel()
    }
    
    var entries: [Entry] {
        get {return model.entries}
    }
    
    func addEntryClicked(date: Date, start: Date, end: Date, pay: Double) {
        // Create Entry
        let entry = model.createEntry(date: date, start: start, end: end, pay: pay)
        // Add
        model.addEntry(entry: entry)
        // Save
        model.save()
        // Update View
        self.objectWillChange.send()
    }
    
}
