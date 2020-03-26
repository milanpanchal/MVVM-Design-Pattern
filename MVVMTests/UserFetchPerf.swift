//
//  UserFetchPerf.swift
//  MVVMTests
//
//  Created by Milan Panchal on 26/03/20.
//  Copyright © 2020 Jeenal Infotech. All rights reserved.
//

import XCTest
@testable import MVVM

class UserFetchPerf: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testUserFetchPerformance() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let exp = expectation(description: "fetching users from server")
            
            let networkManager = NetworkManager.sharedInstance
            networkManager.fetchUsers { (users) in
                XCTAssertNotNil(users, "users should not be nil")
                XCTAssertTrue(users.count > 0, "users should not be empty")
                exp.fulfill()
            }
            
            waitForExpectations(timeout: 10.0) { (error) in
                print(error?.localizedDescription ?? "error")
            }

        }
    }

}
