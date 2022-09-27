//
//  ScheduleNotificationsView.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 21.09.22.
//

import SwiftUI
import CoreLocation


struct ScheduleNotificationsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var viewModel: ScheduleNotificationsViewModel
    @State var frequency: FREQUENCY = .ONCE
    init(_ model: VeggieTrackerModel) {
        viewModel = ScheduleNotificationsViewModel(model)
    }
    var body: some View {
        NavigationView {
            self.form
                .onAppear(perform: viewModel.updateStates)
                .navigationBarTitle("Notifications", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading:
                        Button(action : { self.presentationMode.wrappedValue.dismiss() }){
                            Text("Cancel").foregroundColor(Color.red)
                        },
                    trailing:
                        HStack {
                            Button(action : {
                                viewModel.model.notifications = viewModel.model.notifications
                                self.presentationMode.wrappedValue.dismiss()
                            }){
                                Text("Save")
                            }
                            addButton.disabled(viewModel.disableSaveButton)
                        }
                )
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    /// A button for adding a new notification to the list
    private var addButton: some View {
        Button(action: {
            viewModel.frequency = frequency
            viewModel.save()
        }) {
            Image(systemName: "plus")
        }
    }
    
    private var form: some View {
        Form {
            Section("Scheduled Notifications") {
                List(viewModel.model.notifications) { notification in
                    NavigationLink(destination: NotificationView(notification: notification).environmentObject(viewModel.model)) {
                        Text("\(notification.title)").swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button("Delete", role: .destructive) {
                                viewModel.model.notifications.removeAll { $0.id == notification.id }
                            }
                        }
                    }
                }
            }
            Section("Schedule new Notification") {
                TextField("Title", text: $viewModel.title)
                DatePicker("Time", selection: $viewModel.time, displayedComponents: [.hourAndMinute])
                Picker("Frequency", selection: $frequency) {
                    ForEach(FREQUENCY.allCases, id: \.self) {
                        frequency in Text("\(frequency.rawValue)").tag(frequency as FREQUENCY?)
                    }
                }.pickerStyle(.segmented)
                Toggle("For all children", isOn: $viewModel.allChildren)
                if !viewModel.allChildren {
                    Picker("Child", selection: $viewModel.childSelection) {
                        Text("No Child").tag(nil as Child?)
                        ForEach(viewModel.model.children, id: \.id) {
                            child in Text("\(child.name)").tag(child as Child?)
                        }
                    }
                }
                Picker("Meal", selection: $viewModel.mealSelection) {
                    Text("No Meal").tag(nil as Meal?)
                    ForEach(viewModel.model.meals, id: \.id) {
                        meal in Text("\(meal.name)").tag(meal as Meal?)
                    }
                }
            }
        }
    }
}

struct ScheduleNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleNotificationsView(MockModel())
    }
}
