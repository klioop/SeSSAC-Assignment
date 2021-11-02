//
//  RealmModel.swift
//  SeSAC-week06
//
//  Created by klioop on 2021/11/02.
//

import Foundation
import RealmSwift

// LocalOnlyQsTask is the Task model for this QuickStart
class UserDiary: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted var dateWritten: Date
    @Persisted var registerDate: Date?
    @Persisted var favorite: Bool
    
    convenience init(
        title: String,
        content: String?,
        dateWritten: Date,
        registerDate: Date?
    ) {
        self.init()
        
        self.title = title
        self.content = content
        self.dateWritten = dateWritten
        self.registerDate = registerDate
        self.favorite = false
    }
}
