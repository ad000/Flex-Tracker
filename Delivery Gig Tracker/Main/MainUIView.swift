//
//  MainUIView.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/14/23.
//

import SwiftUI


struct MainUIView: View {
    // View Model
    @MainActor @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.entries, id: \.id) { entry in
                    BlockInfoCellUIView(entry: entry)
                }
            }
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: BlockCreationUIView(viewModel: viewModel)) {
                        Label("Add Entry", systemImage: "plus")
                    }            
                }
            }
            Text("Select an item")
            
        }
    }
}

struct MainUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainUIView()
    }
}
