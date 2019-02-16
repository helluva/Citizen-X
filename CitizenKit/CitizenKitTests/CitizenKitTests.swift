//
//  CitizenKitTests.swift
//  CitizenKitTests
//
//  Created by Cal Stephens on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import XCTest
@testable import CitizenKit

class CitizenKitTests: XCTestCase {

    func testFetchLegislators() {
        let expectation = XCTestExpectation(description: "Fetch Legislators")
        let address = "888 Brannan Street, San Francisco, California"
        
        Phone2Action.fetchLegislators(for: address).then { legislators in
            XCTAssertNotNil(legislators)
            expectation.fulfill()
        }.catch { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
}
