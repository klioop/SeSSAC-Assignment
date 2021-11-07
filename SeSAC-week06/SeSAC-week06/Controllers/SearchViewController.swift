//
//  SearchViewController.swift
//  SeSAC-week06
//
//  Created by klioop on 2021/11/01.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    static let sbID = "SearchViewController"
    
    let localRealm = try! Realm()
    
    let model = DiaryModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
   
    
    func revise(_ object: UserDiary) {
        
        try! localRealm.write {
            object.title = "dfdf"
            object.content = "dfadfad"
        }
        
        // 권장 x
//        try! localRealm.write {
//            let update = UserDiary(value: ["-id" : object._id, "title": "Here"])
//            localRealm.add(update, update: .modified)
//        }

//        try! localRealm.write {
//            localRealm.create(UserDiary.self, value:["_id": object._id, "title": "바꾸자 얘만"], update: .modified)
//        }
        
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemBackground
    }
        
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DiaryModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let diary = DiaryModel.data[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: diary.dateWritten)
        
        cell.textLabel?.text = diary.title
        cell.detailTextLabel?.text = dateString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let diary = DiaryModel.data[indexPath.row]
        let vc = DiaryDetailViewController(userDiary: diary, persistanceManager: PersistanceManager())
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
