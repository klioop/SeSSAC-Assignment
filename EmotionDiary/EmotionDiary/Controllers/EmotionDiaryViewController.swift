//
//  MainViewController.swift
//  EmotionDiary
//
//  Created by klioop on 2021/10/06.
//

import UIKit

class EmotionDiaryViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var emotions: [UIView]!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isAppLaunchFirst()
        configureEmotionTracker()
        configureEmotions()
    }
    
    // MARK: - Private
    
    // 앱이 처음 실행되는지 판단하기 위한 변수
    private var isAppFirstLaunch: Bool = true
    
    private let emotionNames = [
        "행복해", "사랑해", "좋아해", "당황해", "속상해", "우울해", "심심해", "실망해", "슬퍼해"
    ]
    
    private var emotionTracker = [String: Int]() {
        didSet {
            UserDefaults.standard.set(emotionTracker, forKey: "emotionTracker")
        }
    }
    
    // 앱이 두 번째 실행될 때 부터 유저디폴트에 저장된 값(false)을 isAppFirstLaunch 에 저장
    private func isAppLaunchFirst() {
        let firstAppLanuchIndicator = UserDefaults.standard.bool(forKey: "firstLaunchIndicator")
        isAppFirstLaunch = firstAppLanuchIndicator
        
    }
    
    private func configureEmotionTracker() {
        if isAppFirstLaunch {
            emotionNames.forEach {
                emotionTracker[$0] = 0
            }
        } else {
            if let emotionsSaved = UserDefaults.standard.object(forKey: "emotionTracker") as? Dictionary<String, Int> {
                emotionTracker = emotionsSaved
            }
        }
    }
    
    private func configureEmotions() {
        emotions.indices.forEach {
            addTapGesture(to: emotions[$0])
            guard let imageView = emotions[$0].subviews[0] as? UIImageView else { return }
            
            guard let label = emotions[$0].subviews[1] as? UILabel else { return }
            
            let emotionName = emotionNames[$0]
            
            imageView.image = UIImage(named: "mono_slime\($0 + 1)")
            label.text = "\(emotionName) \(emotionTracker[emotionName] ?? 0)"
        }
    }
    
    private func addTapGesture(to view: UIView) {
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didEmotionTapped(by:))))
    }
    
    // MARK: - objc
    
    @objc func didEmotionTapped(by recognizer: UITapGestureRecognizer) {
        let view = recognizer.view
        
        guard let label = view?.subviews[1] as? UILabel else { return }
        
        let emotionName = label.text!.components(separatedBy: " ")[0]
        
        switch recognizer.state {
        case .ended:
            isAppFirstLaunch = false
            UserDefaults.standard.set(isAppFirstLaunch, forKey: "firstLaunchIndicator")
            
            if let oldValue = emotionTracker[emotionName] {
                emotionTracker.updateValue(oldValue + 1, forKey: emotionName)
                label.text = "\(emotionName) \(emotionTracker[emotionName]!)"
            }
        default: return
        }
    }
}
