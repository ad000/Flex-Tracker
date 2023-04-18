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
            // Block Cells
            List {
                ForEach(viewModel.entries, id: \.id) { entry in
                    
                        NavigationLink(
                            destination: RouteInfoUIView(entry: entry)
                        ) {
                            BlockInfoCellUIView(entry: entry)
                        }
                }
            }
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: BlockCreationUIView(viewModel: viewModel)) {
                        Label("Add Entry", systemImage: "plus")
                    }
                }
                
            }
        }
    }
}

struct MainUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainUIView()
    }
}
