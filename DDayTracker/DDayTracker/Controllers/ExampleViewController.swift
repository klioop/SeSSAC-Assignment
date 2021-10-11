//
//  ExampleViewController.swift
//  DDayTracker
//
//  Created by klioop on 2021/10/08.
//

import UIKit

class ExampleViewController: UIViewController {
    // UN = UserNotification
    // 알림의 경우 default 로 foreground 상태에서는 울리지 않는 것으로 설정되어 있음!
    // foreground 알람의 경우 추가 코딩 필요
    // 알림 받고 앱 실행시 badge 제거 코딩 필요
    // 특정 시점 알람 받고 앱 실행시 이전 알람 제거하는 것도 따로 설정 해야함
    // 예약된 알람 삭제도 따로 코딩해야함
    let userNotificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        requestNotificationAuthorization()
    }
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if success {
                self.sendNotification()
            }
        }
    }
    
    func sendNotification() {
        
        // 어떤 정보를 보낼 지 컨텐츠 구성
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "물 마실 시간이에요!"
        notificationContent.body = "하루 2리터 목표 달성을 위해 열심히 달려보아요"
        notificationContent.badge = 100
        notificationContent.subtitle = "안녕!"
        
        // 언제 보낼 지 설정: 간격, 캘린더, 위치
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        // 알림 요청
        // identifier: 알림의 아이디, 알림마다 있음, 같은 아이디의 알람은 새로운 알람으로 교체됨
        let request = UNNotificationRequest(
            identifier: "\(Date())",
            content: notificationContent,
            trigger: trigger
        )
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        // 1. UIAlertController 생성
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let action2 = UIAlertAction(title: "Cancel2", style: .cancel, handler: nil)
        let action3 = UIAlertAction(title: "Cancel3", style: .destructive, handler: nil)
        let action4 = UIAlertAction(title: "Cancel4", style: .default, handler: nil)
        
        alert.addAction(action)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action4)
        
        if #available(iOS 14, *) {
            let coloorPicker = UIColorPickerViewController()
            present(coloorPicker, animated: true, completion: nil)
        }
        
//        present(alert, animated: true, completion: nil)
        
        
        
    }
}
