//
//  HomeViewControllerTest.swift
//  SeSAC-week06Tests
//
//  Created by klioop on 2021/11/01.
//

import XCTest

class HomeViewControllerTest: XCTestCase {
    
    func test_make_sut() throws {
        let sut = try makeSUT()
        
    }
    

    private func makeSUT() throws -> HomeViewController {
        let bundle = Bundle(for: HomeViewController.self)
        let sb = UIStoryboard(name: "Home", bundle: bundle)
        let initialVC = sb.instantiateInitialViewController()
        let navVC = try XCTUnwrap(initialVC as? UINavigationController)
        
        return try XCTUnwrap(navVC.topViewController as? HomeViewController)
    }


}
