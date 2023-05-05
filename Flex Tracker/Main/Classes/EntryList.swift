//
//  EntryList.swift
//  Flex Tracker
//
//  Created by Archael dela Rosa on 5/4/23.
//

import Foundation

class EntryList: ObservableObject {
    @Published var entries: [Entry] = []
    var count: Int {
        get { return self.entries.count}
    }
    
    init() {}
    
    func add(entry: Entry) {
        entries.append(entry)
        sort()
    }
    
    func remove(index: Int) -> Entry? {
       entries.remove(at: index)
    }
    
    func removeAll() {
        entries.removeAll()
    }
    
    func sort() {
        // Sort by: Date > Time Start
        entries = entries.sorted(by: {
            ($0.date, $0.timeStart) >
              ($1.date, $1.timeStart)
        })
    }
}
