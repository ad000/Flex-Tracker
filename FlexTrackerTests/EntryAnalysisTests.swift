//
//  EntryAnalysisTests.swift
//  Flex TrackerTests
//
//  Created by Archael dela Rosa on 4/26/23.
//

import XCTest
@testable import Flex_Tracker

import CoreData

final class EntryAnalysisTests: XCTestCase {
    var model = EntriesModel(test: true)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        model.deleteAllData()
    }

    func testAverageViaHour() throws {
        // Create Entries
        let entry1 = model.createEntry(date: Date(), start: Date().timeStringToDate(timeString: "01:00")!, end: Date().timeStringToDate(timeString: "05:00")!, pay: 84.0)
        entry1.update(routeName: "Portland", end: Date().timeStringToDate(timeString: "03:00")!, milage: 10, milageReturn: 2)
        
        let entry2 = model.createEntry(date: Date(), start: Date().timeStringToDate(timeString: "01:00")!, end: Date().timeStringToDate(timeString: "05:00")!, pay: 84.0)
        entry2.update(routeName: "Portland", end: Date().timeStringToDate(timeString: "04:00")!, milage: 20, milageReturn: 4)
        
        let entry3 = model.createEntry(date: Date(), start: Date().timeStringToDate(timeString: "01:00")!, end: Date().timeStringToDate(timeString: "05:00")!, pay: 84.0)
        entry3.update(routeName: "Portland", end: Date().timeStringToDate(timeString: "05:00")!, milage: 30, milageReturn: 6)
       
        // Analyze
        let analysis = model.getHourAnalysis(4.0)
        print(analysis.toString())
        // Test
        assert(analysis.hoursCompletedAverage == 3.0)
        assert(analysis.hoursCompletedMin == 2.0)
        assert(analysis.hoursCompletedMax == 4.0)
        // Test
        assert(analysis.milageAverage == 20.0)
        assert(analysis.milageMax == 30.0)
        assert(analysis.milageMin == 10.0)
        // Test
        assert(analysis.milageReturnAverage == 4.0)
        assert(analysis.milageReturnMax == 6.0)
        assert(analysis.milageReturnMin == 2.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
