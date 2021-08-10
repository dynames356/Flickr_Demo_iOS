//
//  Flickr_DemoTests.swift
//  Flickr DemoTests
//
//  Created by Jovial on 07/08/2021.
//

import XCTest
@testable import Flickr_Demo

class Flickr_DemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let e = expectation(description: "RequestData")
        
        RequestData.getInstance().getImages(tags: "Electrolux", numberOfImages: 21) { (images, errorMessage) in
            XCTAssertTrue(images.count > 0 && errorMessage.isEmpty)
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
