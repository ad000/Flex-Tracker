//
//  CSVConverterTests.swift
//  Flex TrackerTests
//
//  Created by Archael dela Rosa on 4/26/23.
//

import XCTest
@testable import Flex_Tracker

final class CSVConverterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let tester = CSVConverter()
        assert(tester.data.count > 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
