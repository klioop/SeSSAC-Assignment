//
//  CalendarViewController.swift
//  SeSAC-week06
//
//  Created by klioop on 2021/11/05.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var label: UILabel!
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        
        tasks = localRealm.objects(UserDiary.self)
        
//        let recent = localRealm.objects(UserDiary.self).sorted(byKeyPath: "registerDate", ascending: false).first?.title
//        let photo = localRealm.objects(UserDiary.self).filter("content != nil")
//        let favorite = localRealm.objects(UserDiary.self).filter("favorite == false")
        // String -> ' ', AND, OR
//        let search = localRealm.objects(UserDiary.self).filter("title CONTAINS[c] 'first' OR content CONTAINS[c] 'dd'")
        
        
    }
    
    
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        "dd"
//    }
//
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        "ss"
//    }
//
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        UIImage(systemName: "calendar")
//    }
    
    // date: 시분초까지 모두 동일해야 같음
    // 1. 영국 표준시 기준으로 표기:
    // 2. formatter
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        // 11/2 3개의 일기라면 3개. 없다면 x etc
    
        return tasks.filter("dateWritten == %@", date).count
    }
    
    
}
