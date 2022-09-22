//
//  SmallWidgetView.swift
//  VeggieTracker (iOS)
//
//  Created by Chaima Ghaddab on 22.09.22.
//

import SwiftUI

struct SmallWidgetView: View {
    var entry: Provider.Entry
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SmallWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidgetView(entry: .init(date: .now, configuration: .init(), meals: []))
    }
}
