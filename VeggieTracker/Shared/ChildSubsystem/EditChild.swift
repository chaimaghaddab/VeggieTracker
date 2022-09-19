//
//  EditChild.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 12.04.22.
//´

import SwiftUI
import CoreLocation
import Combine

/// The view responsible for editing a Child's profile within the use's account
struct EditChild: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var viewModel: EditChildViewModel
    
    /// Depending on whether the child exists already or is being created, the title of the sheet changes
    var navigationTitle: String {
        viewModel.id == nil ? "Create Child" : "Edit Child"
    }
    
    init(_ model: VeggieTrackerModel, id: Child.ID) {
        viewModel = EditChildViewModel(model, id: id)
    }
    
    var body: some View {
        NavigationView {
            self.form
                /// fills the entries with the saved information if the child exists
                .onAppear(perform: viewModel.updateStates)
                .navigationBarTitle(navigationTitle, displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    /// Button to cancel the editing/creation of the child's profile
                    leading:
                        Button(action : { self.presentationMode.wrappedValue.dismiss() }){
                            Text("Cancel").foregroundColor(Color.red)
                        },
                    /// Button to save the editing/creation of the child's profile
                    trailing:
                        Button(action : {
                            viewModel.save()
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            Text("Save")
                        }.disabled(viewModel.disableSaveButton))
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    ///  The form to fill to edit/create a child's profile
    private var form: some View {
        Form {
            /// Entry for child's name
            Section(header: Text("Name")) {
                TextField("Name", text: $viewModel.name)
            }
            /// Entry for child's age (Picker style)
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
