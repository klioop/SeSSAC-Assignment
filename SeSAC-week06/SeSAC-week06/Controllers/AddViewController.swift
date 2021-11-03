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
            if let image = addImageView.image {
                saveImageToDocumentDirectory(imageName: "\(task._id).png", image: image)
            }
        }
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        let manager = FileManager.default
        
        // 1. 이미지 저장할 경로 설정: 도큐먼트 폴더, FileManager
        // ex) desktop/jack/ios/folder 고정되어있지 않음
        guard let documnetDirectory = manager
                .urls(
                    for: .documentDirectory,
                       in: .userDomainMask
                )
                .first else {
                    return
                }
        // 2. 이미지 파일 이름 & 최종 경로 설정
        // desktop/jack/ios/folder/222.png
        let imageURL = documnetDirectory.appendingPathComponent(imageName)
        
        // 3. 이미지 압축
        // jpeg for compression
        guard let data = image.pngData() else { return }
        
        // 4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기
        // 4-1. 이미지 경로 여부 확인
        if manager.fileExists(atPath: imageURL.path) {
            // 4-2. 기존 경로에 있는 이미지 삭제
            do {
                try manager.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지를 삭제하지 못했습니다")
            }
        }
        // 5. 이미지를 도큐먼트에 저장
        do {
            try data.write(to: imageURL)
        } catch {
            print("이미지를 저장 못함", error.localizedDescription)
        }
        
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
