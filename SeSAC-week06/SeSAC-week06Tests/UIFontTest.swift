//
//  UIFontTest.swift
//  SeSAC-week06Tests
//
//  Created by klioop on 2021/11/01.
//

import XCTest

class UIFontTest: XCTestCase {

    func test_sCoreDreamFont() throws {
        let fonts = [
            UIFont().sCoreDreamThin,
            UIFont().sCoreDreamLight,
            UIFont().sCoreDreamExtraLight,
            UIFont().sCoreDreamMedium,
            UIFont().sCoreDreamBold,
            UIFont().sCoreDreamExtraBold,
            UIFont().sCoreDreamRegular,
            UIFont().sCoreDreamHeavy,
            UIFont().sCoreDreamBlack
        ]
        
        fonts.forEach {
            XCTAssertNotNil($0)
        }
        XCTAssertEqual(fonts.count, 9)
    }

}
