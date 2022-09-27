//
//  NotificationView.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 27.09.22.
//

import SwiftUI

struct NotificationView: View {
    var notification: Notification
    @EnvironmentObject var model: VeggieTrackerModel
    var body: some View {
        VStack {
            Text(notification.title).font(.title)
            Spacer()
            Text(notification.time.formatted(date: .numeric, time: .shortened))
            Spacer()
            if(notification.allChildren) {
                ForEach(model.children, id: \.self) {
                    Text("\($0.name): \($0.description)")
                }
            } else {
                if let child = model.child(notification.child) {
                    Text("\(child.name): \(child.description)")
                } else {
                    Text("No specified child for this notification")
                }
            }
            if let meal = model.meal(notification.meal) {
                VStack {
                    Text(meal.name)
                    if meal.imageUrl != "" {
                        AsyncImage(url: URL(string: meal.imageUrl!),
                                   content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 300, maxHeight: 300)
                        },
                                   placeholder: {
                            ProgressView()
                        })
                    }
                }
            }
        }.frame(alignment: .center).scaledToFit()
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(notification: Notification())
    }
}
