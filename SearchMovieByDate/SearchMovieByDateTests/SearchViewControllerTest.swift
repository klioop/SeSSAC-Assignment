//
//  SearchViewControllerTest.swift
//  SearchMovieByDateTests
//
//  Created by klioop on 2021/10/26.
//

import XCTest
@testable import SearchMovieByDate

class SearchViewControllerTest: XCTestCase {
    
    func test_canInit() throws {
        let bundle = Bundle(for: SearchViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = sb.instantiateInitialViewController()
        let navVC = try XCTUnwrap(initialVC as? UINavigationController)
        
        _ = try XCTUnwrap(navVC.topViewController as? SearchViewController)
    }
    
    func test_viewDidLoad_setsTitle() throws {
        let bundle = Bundle(for: SearchViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = sb.instantiateInitialViewController()
        let navVC = try XCTUnwrap(initialVC as? UINavigationController)
        
        let sut = try XCTUnwrap(navVC.topViewController as? SearchViewController)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.title, "영화 검색")
    }


}
