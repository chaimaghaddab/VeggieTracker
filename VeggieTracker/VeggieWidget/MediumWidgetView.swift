//
//  MediumWidgetView.swift
//  VeggieWidgetExtension
//
//  Created by Chaima Ghaddab on 22.09.22.
//

import SwiftUI

struct MediumWidgetView: View {
    var entry: Provider.Entry
    var body: some View {
        VStack {
            ForEach(entry.meals, id: \.id) {
                meal in
                VStack {
                    Text(meal.name).font(.title)
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
    }
}

struct MediumWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        MediumWidgetView(entry: Provider.Entry(date: .now, configuration: ConfigurationIntent(), meals: []))
    }
}
