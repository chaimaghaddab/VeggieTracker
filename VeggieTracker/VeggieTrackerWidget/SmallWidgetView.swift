//
//  SmallWidgetView.swift
//  VeggieTracker (iOS)
//
//  Created by Chaima Ghaddab on 22.09.22.
//

import SwiftUI
import WidgetKit

struct SmallWidgetView: View {
    var entry: Provider.Entry
    
    var notification: Notification {
        let nextNotification = entry.notifications.sorted(by: { n1, n2 in
            n1.time < n2.time
        }).filter({$0.time >= .now}).first
        return (nextNotification == nil) ? Notification() : nextNotification!
    }
    
    var body: some View {
        VStack {
            Text("Your next notification is on")
                .font(.system(size: 18))
                .padding(3)
            
            Text(notification.time.formatted(date: .numeric, time: .shortened))
                .frame(alignment: .center)
                .padding(5)
                .font(.title2)
                .background(Color(.init(red: 0, green: 0.6, blue: 0, alpha: 1)))
                .cornerRadius(10)
                .padding(5)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.white)
        .background(.green)
        .widgetURL(URL(string: "veggie://notifications/\(notification.id)"))
    }
}

struct SmallWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidgetView(entry: .init(date: .now, configuration: .init(), meals: [], notifications: [Notification()]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
