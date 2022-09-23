//
//  MediumWidgetView.swift
//  VeggieWidgetExtension
//
//  Created by Chaima Ghaddab on 22.09.22.
//

import SwiftUI
import WidgetKit

struct MediumWidgetView: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(entry.sortedMeals.prefix(3), id: \.id) { meal in
                VStack {
                    Link(destination: URL(string: "veggie://meals/\(meal.id!)")!) {
                        HStack {
                            Image(systemName: "leaf.circle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.green)
                                .padding(.leading)
                            Text(meal.name)
                                .font(.system(size: 18))
                            Spacer()
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.black.opacity(0.7), lineWidth: 1)
                    .background(.black.opacity(0.1))
                    .padding(4)
            }
            .padding(.horizontal)
        }
        .background(Image("veggies").opacity(0.3))
    }
}

struct MediumWidgetView_Previews: PreviewProvider {
    static let mockModel = MockModel.init()
    
    static var previews: some View {
        MediumWidgetView(entry: Provider.Entry(date: .now, configuration: ConfigurationIntent(), meals: mockModel.meals, notifications: mockModel.notifications))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
