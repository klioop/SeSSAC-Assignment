//
//  String+extension.swift
//  SeSAC-week06
//
//  Created by klioop on 2021/11/01.
//

import Foundation

extension String {
    func localized(tableName: String = "Localizable") -> String {
        NSLocalizedString(self, tableName: tableName, bundle: .main, value: "", comment: "")
    }
}
