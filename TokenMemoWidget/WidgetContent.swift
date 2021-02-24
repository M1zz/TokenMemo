//
//  WidgetContent.swift
//  TokenMemo
//
//  Created by 이현호 on 2020/12/05.
//

import Foundation
import WidgetKit

struct WidgetContent: TimelineEntry {
    var date = Date()
    var title: String
    var content: String
}
