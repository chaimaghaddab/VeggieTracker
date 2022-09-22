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
        Text(entry.notification.time.formatted(date: .omitted, time: .shortened))
    }
}

struct SmallWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidgetView(entry: .init(date: .now, configuration: .init(), meals: [], notification: Notification(id: UUID(), title: "", time: .now, frequency: .ONCE, child: nil, allChildren: true)))
    }
}
