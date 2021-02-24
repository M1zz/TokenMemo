//
//  MemoItem.swift
//  TokenMemo
//
//  Created by 이현호 on 2020/12/03.
//

import Foundation

class MemoItem {
    var title: String
    var description: String
    
    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

extension MemoItem {
    public class func getMockData() -> [MemoItem] {
        return [MemoItem(title: "신한은행계좌번호", description: "110488538017"),
                MemoItem(title: "집주소", description: "경기 용인시 수지구 도마치로89번길 16")]
    }
}
