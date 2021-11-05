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
    
    let persistanceManager = PersistanceManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        configureOutlets()

    }
    
    @IBAction func didTapDateButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "날자 썬택", message: "날짜를 선택해 주세요", preferredStyle: .alert)
        guard let contentView = self.storyboard?.instantiateViewController(withIdentifier: DatePickerViewController.sbID) as? DatePickerViewController else { return }
//        contentView.preferredContentSize = CGSize(
//            width: UIScreen.main.bounds.width,
//            height: UIScreen.main.bounds.height
//        )
        contentView.preferredContentSize.height = 200
        
        alert.setValue(contentView, forKey: "contentViewController")
        let cancel = UIAlertAction(title: "취소", style: .default, handler: nil)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            // 확인 버튼을 눌렀을 때 버튼의 타이틀 변경
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일"
            let value = formatter.string(from: contentView.datePicker.date)
            self.dateButton.setTitle(value, for: .normal)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        let date = dateButton.currentTitle ?? "2000년 10월 1일"
        let value = formatter.date(from: date) ?? Date()
        
        // Add some tasks
        let task = UserDiary(
            title: textField.text ?? "no title",
            content: addTextView.text,
            dateWritten: value,
            registerDate: Date()
        )
        try! localRealm.write {
            localRealm.add(task)
//            if let image = addImageView.image {
//                self.saveImageToDocumentDirectory(imageName: "\(task._id).png", image: image)
//            }
        }
        dismiss(animated: true, completion: nil)
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
