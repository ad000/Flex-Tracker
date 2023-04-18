//
//  Delivery_Gig_TrackerTests.swift
//  Delivery Gig TrackerTests
//
//  Created by Archael dela Rosa on 3/29/23.
//

import XCTest
@testable import Delivery_Gig_Tracker

final class Delivery_Gig_TrackerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEntryListSorting() throws {
        let model = EntriesModel(test: true)
        // Create Test Entries
        let a = model.createEntry(date: Date(), start: Date(), end: Date(), pay: 1)
        let b = model.createEntry(date: Date(), start: Date(), end: Date(), pay: 1)
        let c = model.createEntry(date: Date(), start: Date(), end: Date(), pay: 1)
        // Add unordered Entries
        model.addEntry(entry: a)
        model.addEntry(entry: b)
        model.addEntry(entry: c)
        // Assert Correct Order
        XCTAssertTrue(model.entries[0].id == a.id)
        XCTAssertTrue(model.entries[1].id == b.id)
        XCTAssertTrue(model.entries[2].id == c.id)
    }

    func testCreateEntry() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let dateString = "01-10"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM-dd"
        let dateCurrent = dateFormatter.date(from: dateString)!
        
        let pay = 90.5
        
        let model = EntriesModel(test: true)
        
        // Test Creation
        let entry = model.createEntry(date: dateCurrent, start: dateCurrent, end: dateCurrent, pay: pay)
        XCTAssertTrue(entry.pay == pay)
        XCTAssertTrue(entry.date == dateString)
        
        // Test Add
        model.addEntry(entry: entry)
        XCTAssertTrue(model.entries.count == 1)
        
        // Test Remove Entry
        model.deleteEntry(entry: entry)
        XCTAssertTrue(model.entries.count == 0)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
