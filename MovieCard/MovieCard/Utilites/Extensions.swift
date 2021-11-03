//
//  Extensions.swift
//  MovieCard
//
//  Created by klioop on 2021/10/21.
//

import Foundation
import UIKit

// MARK: - UIAlertController extension

extension UIAlertController {
    
    func addActions(_ actions: UIAlertAction...) {
        actions.forEach { addAction($0) }
    }
}

// MARK: - UIViewController extension

extension UIViewController {
    
    func showAlert(
        title: String,
        message: String,
        okTitle: String,
        okAction: @escaping () -> ()
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: okTitle, style: .default) { _ in
            okAction()
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
}

@propertyWrapper
struct UserDefaultWrapper<Value> {
    let key: String
    let defaultValue: Value
    let container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get { container.object(forKey: key) as? Value ?? defaultValue }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

// MARK: - UserDefaults extension

extension UserDefaults {
    
    public enum Key: String {
        case hasOnBoarded
        case date
    }
    
    @UserDefaultWrapper(key: Key.hasOnBoarded.rawValue, defaultValue: false)
    static var hasOnBoarded: Bool
    
    @UserDefaultWrapper(key: Key.date.rawValue, defaultValue: -1)
    static var date: Int
    
}
