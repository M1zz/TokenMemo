//
//  TokenError.swift
//  TokenMemo
//
//  Created by 이현호 on 2021/02/23.
//

import Foundation

enum TokenError: String, Error {
    case uableToFavorite = "추가를 할 수 없습니다. 다시 시도해주세요."
    case alreadyInFavorites = "이미 메모가 등록 되어있습니다."
}
