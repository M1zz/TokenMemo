//
//  EntryView.swift
//  TokenMemo
//
//  Created by 이현호 on 2020/12/05.
//

import SwiftUI

struct EntryView: View {
    let model: WidgetContent
    let userDefaults = UserDefaults.standard
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.title)
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding([.leading], 15)
                .padding([.trailing], 15)
                .padding([.top], 15)
            
            Text(model.content)
                .font(.body)
                .lineLimit(nil)
                .padding([.top], 1)
                .padding([.leading], 15)
                .padding([.trailing], 15)
                .padding([.bottom], 15)
        }
        .background(Color(UIColor(red: 235/255, green: 239/255, blue: 186/255, alpha: 1.0 )))
        .cornerRadius(15)
        .padding()
        
        
    }
}
