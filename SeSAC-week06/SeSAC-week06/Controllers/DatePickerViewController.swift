//
//  DatePickerViewController.swift
//  SeSAC-week06
//
//  Created by klioop on 2021/11/05.
//

import UIKit

class DatePickerViewController: UIViewController {
    static let sbID = "DatePickerViewController"
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.preferredDatePickerStyle = .wheels
    }
}
