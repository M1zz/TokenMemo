//
//  PersistenceManager.swift
//  TokenMemo
//
//  Created by 이현호 on 2021/02/23.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {

    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let memos = "memos"
    }
    
    
    static func save(memos: [MemoItem]) {
        let data = memos.map {
            ["title": $0.title, "description": $0.description]
        }
        
        defaults.set(data, forKey: Keys.memos)
        defaults.synchronize()
    }
    
    
    static func retrieveMemos() -> [MemoItem] {
        guard let data = defaults.object(forKey: Keys.memos) as? [[String: AnyObject]] else {
            return []
        }
        
        list = data.map {
            let title = $0["title"] as? String ?? "error"
            let description = $0["description"] as? String ?? "error"
            
            return MemoItem(title: title, description: description)
        }
        
        return list
    }
    
//    static func updateWith(memo: MemoItem, actionType: PersistenceActionType, completed: @escaping (TokenError?) -> Void) {
//        retrieveMemos { (result) in
//            switch result {
//            case .success(var memos):
//
//                switch actionType {
//                case .add:
//                    guard !memos.contains(memo) else {
//                        completed(.alreadyInFavorites)
//                        return
//                    }
//
//                    memos.append(memo)
//                case .remove:
//                    memos.removeAll { $0.login == memos.login }
//                }
//
//            completed(save(favorites: favorites))
//
//            case .failure(let error):
//                completed(error)
//            }
//        }
//    }
}
