//
//  ContentViewController.swift
//  SeSAC-week06
//
//  Created by klioop on 2021/11/01.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var addImageView: UIImageView!
    
    @IBOutlet weak var addTextView: UITextView!
    
    @IBOutlet weak var dateButton: UIButton!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let sbID = "AddViewController"
    
    let localRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTapDateButton(_ sender: UIButton) {
        
    }
    @IBAction func didTapSaveButton(_ sender: Any) {
        // Add some tasks
        let task = UserDiary(
            title: "First",
            content: "Hello, World!",
            dateWritten: Date(),
            registerDate: Date()
        )
        try! localRealm.write {
            localRealm.add(task)
        }
        print("SAVED!")
        
    }
    @IBAction func didTapCancelButton(_ sender: Any) {
        
    }
    
    private func configureOutLets() {
        textField.placeholder = AddViewLocalization.textFieldPlaceholder.rawValue.localized(tableName: "AddViewController")
    }
    
}
