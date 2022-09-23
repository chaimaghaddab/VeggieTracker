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
        entry.notifications.isEmpty ? Notification() : entry.notifications[0]
    }
    
    var body: some View {
        VStack {
            Text("Your next notification is on")
                .font(.system(size: 18))
                .padding(.bottom, 3)
            
            Text(notification.time.formatted(date: .abbreviated, time: .shortened))
                .padding(5)
                .font(.title2)
                .background(Color(.init(red: 0, green: 0.6, blue: 0, alpha: 1)))
                .cornerRadius(10)
                .padding(5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.white)
        .background(.green)
    }
}

struct SmallWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidgetView(entry: .init(date: .now, configuration: .init(), meals: [], notifications: [Notification()]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}