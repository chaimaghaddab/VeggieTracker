//
//  CircularWidgetView.swift
//  VeggieTrackerWidgetExtension
//
//  Created by Tarlan Ismayilsoy on 23.09.22.
//

import SwiftUI
import WidgetKit

struct CircularWidgetView: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Circle()
            RoundedRectangle(cornerRadius: 7)
                .stroke(lineWidth: 1.5)
                .foregroundColor(.black)
                .padding(13)
            
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "leaf.circle.fill")
                        .font(.system(size: 19))
                        .foregroundColor(.black)
                        .padding([.trailing, .top], 5)
                        .background(.primary)
                }
                Spacer()
            }
            
                Text("\(entry.notifications.count)")
                .font(.system(size: 20).weight(.semibold))
                .foregroundColor(.black)
        }
    }
}

struct CircularWidgetView_Previews: PreviewProvider {
    static let mockModel = MockModel.init()
    
    static var previews: some View {
        CircularWidgetView(entry: Provider.Entry(date: .now, configuration: ConfigurationIntent(), meals: mockModel.meals, notifications: mockModel.notifications))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
