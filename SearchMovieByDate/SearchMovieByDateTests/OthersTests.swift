//
//  OthersTests.swift
//  SearchMovieByDateTests
//
//  Created by klioop on 2021/10/26.
//

import XCTest
@testable import SearchMovieByDate

class OthersTests: XCTestCase {
    func test_makeUrlQueryString() throws {
        let apiManager = API.api
        let queryParams = ["name": "sam"]
        
        XCTAssertTrue(apiManager.makeUrlQueryString().contains(API.Constants.key))
        XCTAssertTrue(apiManager.makeUrlQueryString(queryParams: queryParams).contains("name=sam"))
    }

}
