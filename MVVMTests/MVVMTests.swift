//
//  MVVMTests.swift
//  MVVMTests
//
//  Created by Milan Panchal on 18/03/20.
//  Copyright © 2020 Jeenal Infotech. All rights reserved.
//

import XCTest
@testable import MVVM

class MVVMTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserViewModel() {
        
        let name = Name.init(title: "Mr.", first: "Milan", last: "Panchal")
        let picture = Picture.init(large: "", medium: "", thumbnail: "https://avatars3.githubusercontent.com/u/2879673?s=60&u=8fd05ac67922b601e84f9c55e011307547dee445&v=4")
        let user = User.init(gender: "Male", name: name, email: "test@gmail.com", picture: picture, nat: "IN", cell: "123456789", phone: "9898989898")
        
        let userViewModel = UserViewModel(user: user)
        
        // Check for Nil or empty string URL
        XCTAssertNotNil(user.picture.thumbnail)
        XCTAssertNotEqual(user.picture.thumbnail, "")
        
        // Check for valid URL
        XCTAssertNotNil(userViewModel.thumbnailImageUrl)
        
        XCTAssertEqual([user.name.title, user.name.first, user.name.last].joined(separator: " "), userViewModel.fullName)
        XCTAssertEqual([user.cell, user.phone].joined(separator: " / "), userViewModel.contactNumber)

    }
    
    func testFetchUserList() {
        
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
