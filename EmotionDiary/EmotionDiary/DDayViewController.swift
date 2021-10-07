//
//  DDayViewController.swift
//  EmotionDiary
//
//  Created by klioop on 2021/10/07.
//

import UIKit

class DDayViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        /*
         DateFormatter
         1. DateFormat
         2. Locale - Setting time zone
         */
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 M월 dd일 hh시 m분" // 21/10/20
        formatter.locale = .current
        let value = formatter.string(from: sender.date)
        print(value)
        
        // 100일 뒤: TimerInterval, Calender
        let afterDate = Date(timeInterval: 86400 * 100, since: sender.date)
        print(formatter.string(from: afterDate))
        
        
    }
    
}
