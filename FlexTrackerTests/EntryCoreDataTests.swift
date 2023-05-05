//
//  EntryCoreDataTests.swift
//  Flex TrackerTests
//
//  Created by Archael dela Rosa on 5/3/23.
//

import XCTest
@testable import Flex_Tracker


final class EntryCoreDataTests: XCTestCase {
    var model: EntriesModel = EntriesModel(test: true)

    override func setUpWithError() throws {
        model.deleteAllData()
    }

    override func tearDownWithError() throws {
        model.deleteAllData()
    }

    func testEntryExists() throws {
        let date = Date().dateStringToDate(dateString: "04-16")!
        let date2 = Date().dateStringToDate(dateString: "03-16")!
        let timeStart = Date().timeStringToDate(timeString: "01:45")!
        let timeEnd = Date().timeStringToDate(timeString: "05:45")!
        let entry1 = model.createEntry(
            date: date,
            start: timeStart,
            end: timeEnd,
            pay: 84.0)
        model.addEntry(entry: entry1)
        // Test
        assert(model.checkEntryExists(date: date, time: timeStart) == true)
        assert(model.checkEntryExists(date: date2, time: timeStart) == false) // Wrong Date
        assert(model.checkEntryExists(date: date, time: timeEnd) == false)  // Wrong Time
    }
    
    func testEntryFetchWithLimitAndOffsetsAndSorting() throws {
        var entries: [Entry] = []
        // Create Entries
        for m in 1...12 { // Month
            let date = Date().dateStringToDate(dateString: String((m <= 9) ? "0"+String(m) : String(m))+"-01")!
            for h in 1...6 { // Hour
                let timeStart = Date().timeStringToDate(timeString: String((h <= 9) ? "0"+String(h) : String(h))+":00")!
                let timeEnd = Date().timeStringToDate(timeString: String((h <= 9) ? "0"+String(h) : String(h))+":30")!
                
                let entry = model.createEntry(date: date, start: timeStart, end: timeEnd, pay: 10)
                entries.append(entry)
            }
        }
        model.save() // Save so offset will work (issue with fetchOffset not working with unsaved changes)
        let batch1 = model.fetchEntries(count: 4, offset: 0).map{$0.id}
        dump( model.fetchEntries(count: 4, offset: 0).map{[$0.date, $0.timeStart]})
        
        assert(batch1.contains(entries.popLast()!.id))
        assert(batch1.contains(entries.popLast()!.id))
        assert(batch1.contains(entries.popLast()!.id))
        assert(batch1.contains(entries.popLast()!.id))
        let batch2 = model.fetchEntries(count: 3, offset: 4).map{$0.id}
        dump( model.fetchEntries(count: 3, offset: 4).map{[$0.date, $0.timeStart]})
        assert(batch2.contains(entries.popLast()!.id))
        assert(batch2.contains(entries.popLast()!.id))
        assert(batch2.contains(entries.popLast()!.id))
        
        model.deleteAllData()
        model.save()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
