//
//  ChildrenList.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import SwiftUI
import os

/// The view representing the list of children entered by the user
struct ChildrenListView: View {
    @EnvironmentObject private var model: VeggieTrackerModel
    /// if true, the sheet to add a new child to the list of children is added
    @State var presentAddChild = false
    
    let logger = Logger(subsystem: "chaima.ghaddab.VeggieTracker", category: "ChildView")
    
    var body: some View {
        List {
            /// children are sorted based on age
            ForEach (model.children.sorted()) {
                child in
                /// The view contains links leading to each child's details view
                NavigationLink(destination: ChildView(child: child)) {
                    HStack{
                        Text("\(child.name)")
                        Spacer()
                        Text("\(child.description)").foregroundColor(Color.mint)
                    }
                }
            }
        }
        .navigationTitle("Children")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                /// A button for adding a new child to the list
                addButton
            }
        }.sheet(isPresented: $presentAddChild) {
            EditChild(self.model, id: nil)
        }
    }
    
    /// A button for adding a new child to the list
    private var addButton: some View {
        Button(action: { self.presentAddChild = true
            logger.log("Add a new child")
        }) {
            Image(systemName: "plus")
        }
    }
}

struct ChildrenList_Previews: PreviewProvider {
    private static let model: VeggieTrackerModel = MockModel()
    static var previews: some View {
        ChildrenListView(presentAddChild: true).environmentObject(model)
    }
}
