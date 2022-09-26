//
//  VeggieTrackerWidget.swift
//  VeggieTrackerWidget
//
//  Created by Chaima Ghaddab on 22.09.22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), meals: [], notifications: [Notification(id: UUID(), title: "", time: .now, frequency: .ONCE, child: nil, allChildren: true)])
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, meals: MockModel().meals, notifications: MockModel.init().notifications)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let model = MockModel()
            model.readMeals()
            print(model.meals)
            let entry = SimpleEntry(date: entryDate, configuration: configuration, meals: model.meals, notifications: model.notifications)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let meals : [Meal]
    let notifications: [Notification]
    
    var sortedMeals: [Meal] {
        switch configuration.recipeSort {
        case .veggies:
            return meals.sorted { mealOne, mealTwo in
                mealOne.veggies.count > mealTwo.veggies.count
            }
        case.name:
            return meals.sorted { mealOne, mealTwo in
                mealOne.name.lowercased() > mealTwo.name.lowercased()
            }
        default:
            return meals
        }
    }
}

struct VeggieWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case.systemMedium:
            MediumWidgetView(entry: entry)
        default:
            Text("This size not supported :(")
        }

    }
}

@main
struct VeggieTrackerWidget: Widget {
    let kind: String = "VeggieWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            VeggieWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("VeggieWidget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}


struct VeggieTrackerWidget_Previews: PreviewProvider {
    static var previews: some View {
        VeggieWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), meals: [], notifications: MockModel.init().notifications))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
