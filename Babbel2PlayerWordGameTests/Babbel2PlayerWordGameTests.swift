//
//  Babbel2PlayerWordGameTests.swift
//  Babbel2PlayerWordGameTests
//
//  Created by Vaibhav Bangde on 7/27/19.
//  Copyright © 2019 Vaibhav Bangde. All rights reserved.
//

import XCTest
@testable import Babbel2PlayerWordGame

class Babbel2PlayerWordGameTests: XCTestCase {
    var fetchWordData : FetchWordsData!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fetchWordData = FetchWordsData(fileName: "words")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(fetchWordData.words?[0].text_eng, "primary school")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
