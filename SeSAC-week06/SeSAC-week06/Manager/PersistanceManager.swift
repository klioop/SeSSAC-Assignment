//
//  PersistanceManager.swift
//  SeSAC-week06
//
//  Created by klioop on 2021/11/03.
//

import UIKit.UIImage
import RealmSwift

class PersistanceManager {
    
    static let shared: PersistanceManager = PersistanceManager()
    
    private let localRealm = try! Realm()
    
    func getAllDiary() -> Results<UserDiary> {
        localRealm.objects(UserDiary.self)
    }
    
    func addObject(_ object: UserDiary) {
        do {
            try localRealm.write {
                localRealm.add(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteObject(_ object: UserDiary) {
        do {
            try localRealm.write {
                localRealm.delete(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func makeSubDirectoryInDocument(with name: String) {
        let manager: FileManager = .default
        let path = manager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(name)
        if !manager.fileExists(atPath: path.path) {
            try! manager.createDirectory(
                at: path,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
    }
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        let manager = FileManager.default
        let imageDirectoryUrl = manager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("images", isDirectory: true)
        
        if !manager.fileExists(atPath: imageDirectoryUrl.path) {
            makeSubDirectoryInDocument(with: "images")
        }
        
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
        let imageURL = documnetDirectory.appendingPathComponent("images/\(imageName).png")
        
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
    
}
