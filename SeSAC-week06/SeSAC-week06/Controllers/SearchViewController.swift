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
    
    
    
}
