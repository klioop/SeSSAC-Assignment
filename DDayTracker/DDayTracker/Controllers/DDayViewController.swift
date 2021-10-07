//
//  DDayViewController.swift
//  DDayTracker
//
//  Created by klioop on 2021/10/07.
//

import UIKit

class DDayViewController: UIViewController {
   
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let cardViews = [CardView(), CardView(), CardView(), CardView()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubViews(cardViews)
        configureDatePicker()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layOutCardViews()
    }
    
    private func layOutCardViews() {
        let cardViewSize = (view.width) / 2 - 50
        cardViews[0].frame = CGRect(
            x: view.width - cardViewSize - 40,
            y: datePicker.bottom,
            width: cardViewSize,
            height: cardViewSize
        )
        
        cardViews[1].frame = CGRect(
            x: view.safeAreaInsets.left + 40,
            y: datePicker.bottom,
            width: cardViewSize,
            height: cardViewSize
        )
        
        cardViews[2].frame = CGRect(
            x: view.safeAreaInsets.left + 40,
            y: cardViews[0].bottom + 10,
            width: cardViewSize,
            height: cardViewSize
        )
        
        cardViews[3].frame = CGRect(
            x: view.width - cardViewSize - 40,
            y: cardViews[0].bottom + 10,
            width: cardViewSize,
            height: cardViewSize
        )
    }
    
    private func configureDatePicker() {
        if #available(iOS 14, *) {
            if UIScreen.main.bounds.height > 670 {
                datePicker.preferredDatePickerStyle = .inline
            } else {
                datePicker.preferredDatePickerStyle = .wheels
            }
        }
    }
    

}
