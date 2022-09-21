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
                        Button(action : {
                            viewModel.frequency = frequency
                            viewModel.save()
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            Text("Save")
                        }.disabled(viewModel.disableSaveButton))
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var form: some View {
        Form {
            Section("Scheduled Notifications") {
                ForEach(viewModel.model.notifications) {notification in
                    Text("\(notification.title)")
                }
            }
            Section("Schedule new Notification") {
                
                Section() {
                                    TextField("Title", text: $viewModel.title)
                }
                
                Section() {
                    DatePicker("Time", selection: $viewModel.time, displayedComponents: [.hourAndMinute])
                }
                Section() {
                                    Picker("Frequency", selection: $frequency) {
                                        ForEach(FREQUENCY.allCases, id: \.self) {
                                            frequency in Text("\(frequency.rawValue)")
                                        }
                                    }.pickerStyle(WheelPickerStyle())
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