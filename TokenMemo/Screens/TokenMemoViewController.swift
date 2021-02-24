//
//  TokenMemoTableViewController.swift
//  TokenMemo
//
//  Created by 이현호 on 2020/12/03.
//

import UIKit

var list = [MemoItem]()

class TokenMemoTableViewController: UITableViewController {
    
    private var memoItems = list
    private var isFirstshortcut: Bool = true
    private let itemRow: Int = 1
    private let rowHeight: CGFloat = 80
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: CustomCellIdentifier.tokenMemoTableViewCell , bundle: nil),
                           forCellReuseIdentifier: CustomCellIdentifier.tokenMemoTableViewCell)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memoItems = PersistenceManager.retrieveMemos()
        
        if UIPasteboard.general.string?.isEmpty != nil,
           isFirstshortcut {
            showShortcutViewContoller()
        }
        
        tableView.reloadData()
    }
    
    
    private func showShortcutViewContoller() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "shortcutBoardID")
        //self.navigationController?.present(vc, animated: true, completion: nil)
        vc?.modalPresentationStyle = .custom
        present(vc!, animated: true, completion: nil)

        isFirstshortcut = false
    }
}


extension TokenMemoTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return memoItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemRow
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifier.tokenMemoTableViewCell, for: indexPath) as! TokenMemoTableViewCell
        let item = memoItems[indexPath.section]
        cell.set(for: item)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let title = memoItems[indexPath.section].title
        let description = memoItems[indexPath.section].description
        UIPasteboard.general.string = description
        HelperFunctions.makeToast("[\(description)] 가 \n클립보드에 복사되었습니다.")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            var data = list.map {
                ["title": $0.title, "description": $0.description]
            }
            data.remove(at: indexPath.section)
            list.remove(at: indexPath.section)
            memoItems = list
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: "items")
            userDefaults.synchronize()
            
            self.tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
        }
    }
}


extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupId = "group.com.Ysoup.TokenMemo"
        return UserDefaults(suiteName: appGroupId)!
    }
}
