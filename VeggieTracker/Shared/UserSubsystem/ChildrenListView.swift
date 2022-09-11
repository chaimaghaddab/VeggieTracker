//
//  ChildrenList.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import SwiftUI
import os

struct ChildrenListView: View {
    @EnvironmentObject private var model: VeggieTrackerModel
    @State var presentAddChild = false
    
    let logger = Logger(subsystem: "chaima.ghaddab.VeggieTracker", category: "ChildView")
    
    var body: some View {
        List {
            ForEach (model.children.sorted()) {
                child in
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
                addButton
            }
        }.sheet(isPresented: $presentAddChild) {
            EditChild(self.model, id: nil)
        }
    }
    
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
