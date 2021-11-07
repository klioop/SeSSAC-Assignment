//
//  ContentViewController.swift
//  SeSAC-week06
//
//  Created by klioop on 2021/11/01.
//

import UIKit
import RealmSwift
import Photos
import PhotosUI

class AddViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    @IBOutlet weak var addTextView: UITextView!
    
    @IBOutlet weak var dateButton: UIButton!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    private let sbID = "AddViewController"
    
    let localRealm = try! Realm()
    
    private let persistanceManager = PersistanceManager.shared
    
    private var images: [UIImage] = [UIImage(systemName: "star")!]

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOutlets()
//        print(localRealm.configuration.fileURL!)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photoCollectionView.reloadData()
    }
    
    private func configurePHPhotoPickerAndReturnPHPickerVC() -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 10
        config.filter = .any(of: [.images, .livePhotos])
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        
        return vc
    }
    
    @IBAction func didTapAddPhotoButton(_ sender: UIButton) {
        let phvc = configurePHPhotoPickerAndReturnPHPickerVC()
        self.present(phvc, animated: true, completion: nil)
    }
    
    @IBAction func didTapDateButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "날자 선택", message: "날짜를 선택해 주세요", preferredStyle: .alert)
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
        }
        saveImages(to: task)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    private func saveImages(to diary: UserDiary) {
        if !images.isEmpty {
            images.indices.forEach { [weak self] index in
                let imageName = "\(diary.title)_\(index + 1)"
                let imageObject =  UserDiaryImage(name: imageName)
                try! localRealm.write {
                    localRealm.add(imageObject)
                    diary.images.append(imageObject)
                }
                self?.persistanceManager.saveImageToDocumentDirectory(imageName: imageName, image: (self?.images[index])!)
            }
        }
    }
    
    private func configureOutlets() {
        dateButton.backgroundColor = .systemBlue
        dateButton.setTitleColor(.white, for: .normal)
        dateButton.layer.cornerRadius = 6
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        dateButton.setTitle(formatter.string(from: Date()), for: .normal)
        
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
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        let layOut = UICollectionViewFlowLayout()
        layOut.scrollDirection = .horizontal
        let nib = UINib(nibName: AddPhotoCollectionViewCell.cellID, bundle: nil)
        
        photoCollectionView.register(nib, forCellWithReuseIdentifier: AddPhotoCollectionViewCell.cellID)
        photoCollectionView.collectionViewLayout = layOut
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
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

extension AddViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        results.forEach { [weak self] result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else {
                    return
                }
                self?.images.append(image)
                
                DispatchQueue.main.async {
                    self?.photoCollectionView.reloadData()
                }
            }
        }
    }
}

// MARK: - collection view

extension AddViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddPhotoCollectionViewCell.cellID, for: indexPath
        ) as? AddPhotoCollectionViewCell else { fatalError("Could not find the cell!!") }
        
        let image = images[indexPath.item]
                
        cell.phImageView2.image = image
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 100, height: collectionView.frame.height - 10)
    }
}
