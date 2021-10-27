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
       _ = try makeSUT()
    }
    
    func test_viewDidLoad_setsTitle() throws {
        let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.title, "영화 검색")
    }
    
    func test_configure_tableView() throws {
        let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    private func makeSUT() throws -> SearchViewController {
        let bundle = Bundle(for: SearchViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = sb.instantiateInitialViewController()
        let navVC = try XCTUnwrap(initialVC as? UINavigationController)
        
        return try XCTUnwrap(navVC.topViewController as? SearchViewController)
    }
    
}

private extension SearchViewController {
    var tableView: UITableView {
        resultTableView
    }
}
