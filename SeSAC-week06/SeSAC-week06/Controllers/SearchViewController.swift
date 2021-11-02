//
//  SearchViewController.swift
//  SeSAC-week06
//
//  Created by klioop on 2021/11/01.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    
    static let sbID = "SearchViewController"
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = localRealm.objects(UserDiary.self)
//        print(tasks)
    }
    
    
    
}
