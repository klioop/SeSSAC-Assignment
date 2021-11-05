//
//  SettingViewController.swift
//  SeSAC-week06
//
//  Created by klioop on 2021/11/04.
//

import UIKit
import Zip
import MobileCoreServices
import RealmSwift

class SettingViewController: UIViewController {
    /*
     백업
     - 사용자의 아이폰 저장 공간 확인
       - 부족: 백업 불가
     - 백업 진행
       - 백업 가능한 파일 여부 확인, realm, folder
         - ex) 이미지라면 이미지 폴더에 이미지가 있는지
       - 데이터가 없다면 백업할 데이터가 없다고 안내
       - 백그라운드 기능 or progress + UI 인터렉션 금지
     - zip
       - 백업 완료 시점에
       - Progress + UI 인터렉션 허용
     - 공유화면
     */
    
    /*
     복구
     - 사용자의 아이폰 저장 공간 확인
     - 파일 앱
       - zip
       - zip 선택
     - zip -> unzip
       - 백업 파일 이름 확인
       - 압축 해제
         - 백업 파일 확인: 폴더, 파일 이름
         - 정상적인 파일인가
     - 백업 당시 데이터와 지금 현재 앱에서 사용중인 앱의 데이터를 어떻게 합칠지
       - 데이터 선택
     */
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let localRealm = try! Realm()
        let temps = localRealm.objects(UserDiary.self)
        temps.forEach {
            print($0.title)
        }
    }
    
    @IBAction func didTapRestoreBtn() {
        // 복구 1. 파일 앱 열기 + 확장자
        // import MobileCoreServices
        let documentPicker = UIDocumentPickerViewController(
            documentTypes: [kUTTypeArchive as String],
            in: .import
        )
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        self.present(documentPicker, animated: true)
    }
    
    @IBAction func didTapActivityBtn() {
        presentActivityController()
    }
    
    @IBAction func didTapBackUpButton() {
        // 4. 백업할 팔일에 대한 url 배열
        var urlPaths = [URL]()
        
        // 1. 도큐먼트 폴더 위치 (.../document/default.relam)
        if let path = documentDirectoryPath() {
            // 2. 백업하고자 하는 파일 url 확인
            // 이미지 같은 경우 백업 편의성을 위해 디렉토리를 생성하고 디렉토리 내애 이미지를 저장하는 것이 효율적
            let realm = (path as NSString).appendingPathComponent("default.realm")
            
            // 3. 백업하고자 하는 파일 존재 여부 확인
            if FileManager.default.fileExists(atPath: realm) {
                // 5. url 배열에 백업 파일 url 추가
                urlPaths.append(URL(string: realm)!)
            } else {
                print("백업할 파일이 없습니다")
            }
        }
        
        // 6. 백업
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "EXPERIMENT") // Zip
            print(zipFilePath)
            presentActivityController()
        }
        catch {
          print("Something went wrong")
        }
        
    }
    
    func presentActivityController() {
        // 압축 파일 경로 가져오기
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("EXPERIMENT.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        self.present(vc, animated: true)
    }
    
    func documentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let directoryPath = path.first {
            return directoryPath
        } else {
            return nil
        }
    }
}

extension SettingViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function)
        
        // 복구 2. 선택한 파일에 대한 경로 가져와야 함
        guard let selectedFileURL = urls.first else { return }
        let directory = FileManager.default.urls(
            for: .documentDirectory,
               in: .userDomainMask
        ).first!
        let sandbBoxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        // 복구 3. 압축 해제
        if FileManager.default.fileExists(atPath: sandbBoxFileURL.path) {
            // 기존에 복구하고자 하는 zip 파일을 도큐먼트에 가지고 있을 경우, 도큐먼트 위치에 zip 을 압축 해제 하면 된다
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("EXPERIMENT.zip")
                
                try Zip.unzipFile(
                    fileURL,
                    destination: documentDirectory,
                    overwrite: true,
                    password: nil,
                    progress: { progress in print(progress) },
                    fileOutputHandler: {
                        // 복구가 완료 메시지, 앱 재실행 alert
                        print("unzippedFile: \($0)")
                    }
                )
            } catch {
                print(error.localizedDescription)
            }
        } else {
            // 파일 앱의 zip -> 도큐먼트 디렉토리에 복사
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandbBoxFileURL)
                
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("EXPERIMENT.zip")
                
                try Zip.unzipFile(
                    fileURL,
                    destination: documentDirectory,
                    overwrite: true,
                    password: nil,
                    progress: { progress in print(progress) },
                    fileOutputHandler: {
                        // 복구가 완료 메시지, 앱 재실행 alert
                        print("unzippedFile: \($0)")
                    }
                )
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
