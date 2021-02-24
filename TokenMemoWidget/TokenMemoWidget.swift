//
//  TokenMemoWidget.swift
//  TokenMemoWidget
//
//  Created by 이현호 on 2020/12/05.
//

import WidgetKit
import SwiftUI
import Intents


let snapshotEntry = WidgetContent(title: "탭 해주세요?", content: "가장 간단하게 메모를 복사하는 방법")

struct Provider: TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping (WidgetContent) -> Void) {
        let entry = snapshotEntry
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetContent>) -> Void) {
        var entries: [WidgetContent] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = snapshotEntry
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func placeholder(in context: Context) -> WidgetContent {
        snapshotEntry
    }
}

@main
struct TokenMemoWidget: Widget {
    let kind: String = "TokenMemoWidget"
    
    public var body: some WidgetConfiguration {
        StaticConfiguration (
            kind: kind,
            provider: Provider()
        ) { entry in
            EntryView(model: entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(UIColor(red: 99/255, green: 76/255, blue: 62/255, alpha: 1.0 )))
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .configurationDisplayName("설명")
        .description("메모를 한 눈에 볼 수 있도록 도와주는 위젯입니다.")
    }
}

//struct TokenMemoWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        TokenMemoWidgetEntryView(entry: snapshotEntry)
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
