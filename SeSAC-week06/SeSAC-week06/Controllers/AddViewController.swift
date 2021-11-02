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
        configureOutlets()

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
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func configureOutlets() {
        dateButton.backgroundColor = .systemBlue
        dateButton.setTitleColor(.white, for: .normal)
        dateButton.layer.cornerRadius = 6
        
        textField.placeholder = AddViewLocalization
            .Localization
            .textFieldPlaceholder
            .rawValue
            .localized(tableName: AddViewLocalization.tableName)
        saveButton.title = AddViewLocalization
            .Localization
            .save
            .rawValue
            .localized(tableName: AddViewLocalization.tableName)
        cancelButton.title = AddViewLocalization
            .Localization
            .cancel
            .rawValue
            .localized(tableName: AddViewLocalization.tableName)
        configureTextView()
    }
    
    private func configureTextView() {
        addTextView.delegate = self
        addTextView.textColor = .lightGray
        addTextView.text = AddViewLocalization
            .Localization
            .textViewPlaceholder
            .rawValue
            .localized(tableName: AddViewLocalization.tableName)
    }
    
}

extension AddViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .label
    }
}
