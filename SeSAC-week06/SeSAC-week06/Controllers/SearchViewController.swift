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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // 도큐먼트 경로 -> 이미지 찾기 -> UIImage -> UIImageView
    func loadImageFromDocumnetDirectory(imageName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        
        return nil
    }
    
    func deleteImageFromDocument(imageName: String) {
        let manager = FileManager.default
        guard let documnetDirectory = manager
                .urls(
                    for: .documentDirectory,
                       in: .userDomainMask
                )
                .first else {
                    return
                }
        let imageURL = documnetDirectory.appendingPathComponent(imageName)
        if manager.fileExists(atPath: imageURL.path) {
            do {
                try manager.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지를 삭제하지 못했습니다")
            }
        }
    }
    
    
}
