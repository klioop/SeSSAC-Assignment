//
//  String+extensions.swift
//  SearchMovieByDate
//
//  Created by klioop on 2021/10/26.
//

import Foundation

extension String {
    func removeNotNumberCharatersInString() -> String {
        let resultArr = self.map { char -> String in
            if Int(String(char)) == nil {
                return ""
            }
            return String(char)
        }
        return resultArr.joined(separator: "")
    }
}
