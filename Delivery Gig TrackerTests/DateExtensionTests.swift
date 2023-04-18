//
//  DateExtensionTests.swift
//  Delivery Gig TrackerTests
//
//  Created by Archael dela Rosa on 4/18/23.
//

import XCTest

final class DateExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDateToDateString() throws {
        let dateFormatter = DateFormatter()
        // Date to DateString
        dateFormatter.dateFormat = "MM'-'dd"
        let date = dateFormatter.date(from: "01-24")
        
        let dateString = date!.toDateString()
        
        XCTAssertTrue(dateString == "01-24")
    }
    
    func testDateToTimeString() throws {
        let dateFormatter = DateFormatter()
        // Date to TimeString
        dateFormatter.dateFormat = "hh:mm"
        let time = dateFormatter.date(from: "02:45")
        
        let timeString = time!.toTimeString()
        
        XCTAssertTrue(timeString == "02:45")
    }
    
    func testDateStringToDate() throws {
        let dateFormatter = DateFormatter()
        // Date to DateString
        dateFormatter.dateFormat = "MM'-'dd"
        let dateTest = dateFormatter.date(from: "01-24")!
        
        let dateString = "01-24"
        let date = Date().dateStringToDate(dateString: dateString)!
        
        
        XCTAssertTrue(
            Calendar.current.dateComponents([.day, .month], from: date) ==
            Calendar.current.dateComponents([.day, .month], from: dateTest)
        )
        
    }
    
    func testTimeStringToDate() throws {
        let dateFormatter = DateFormatter()
        // Date to TimeString
        dateFormatter.dateFormat = "hh:mm"
        let timeTest = dateFormatter.date(from: "02:45")!
        
        let timeString = "02:45"
        let time = Date().timeStringToDate(timeString: timeString)!
        
        XCTAssertTrue(
            Calendar.current.dateComponents([.hour, .minute], from: time) ==
            Calendar.current.dateComponents([.hour, .minute], from: timeTest)
        )
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
