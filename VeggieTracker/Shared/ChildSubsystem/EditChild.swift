//
//  EditChild.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 12.04.22.
//´

import SwiftUI
import CoreLocation
import Combine

struct EditChild: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var viewModel: EditChildViewModel
    
    var navigationTitle: String {
        viewModel.id == nil ? "Create Child" : "Edit Child"
    }
    
    init(_ model: VeggieTrackerModel, id: Child.ID) {
        viewModel = EditChildViewModel(model, id: id)
    }
    
    var body: some View {
        NavigationView {
            self.form
                .onAppear(perform: viewModel.updateStates)
                .navigationBarTitle(navigationTitle, displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading:
                        Button(action : { self.presentationMode.wrappedValue.dismiss() }){
                            Text("Cancel").foregroundColor(Color.red)
                        },
                    trailing:
                        Button(action : {
                            viewModel.save()
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            Text("Save")
                        }.disabled(viewModel.disableSaveButton))
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var form: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $viewModel.name)
            }
            
            Section(header: Text("Age")) {
                Picker("Age", selection: $viewModel.age) {
                    ForEach(1 ..< 19) {
                        Text("\($0)").tag($0)
                    }
                }.pickerStyle(WheelPickerStyle())
            }
        }
    }
}


struct EditChild_Previews: PreviewProvider {
    private static let model: VeggieTrackerModel = MockModel()
    
    
    static var previews: some View {
        EditChild(model, id: model.children[0].id)
            .environmentObject(model)
    }
}
