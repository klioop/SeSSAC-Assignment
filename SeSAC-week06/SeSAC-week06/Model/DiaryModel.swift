//
//  model.swift
//  SeSAC-week06
//
//  Created by klioop on 2021/11/05.
//

import Foundation
import RealmSwift

struct DiaryModel {
    
    static var data: Results<UserDiary>!
    
    private let persistanceManager: PersistanceManager = .shared
    
    init() {
        DiaryModel.data = persistanceManager.getAllDiary()
    }
    
    func getAllDiary() -> Results<UserDiary> {
        persistanceManager.getAllDiary()
    }
    
    func add(diary: UserDiary) {
        persistanceManager.addObject(diary)
    }
    
    
    
    
    
}
