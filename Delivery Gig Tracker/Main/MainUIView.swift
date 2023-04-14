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
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.entries, id: \.id) { entry in
                    NavigationLink {
                        // TODO REMOVE
                        Text("Block at \(entry.date, formatter: dateFormatter)")
                    } label: {
                        Text(entry.date, formatter: dateFormatter)
                        Text(entry.timeStart, formatter: timeFormatter)
                        Text(entry.timeEnd, formatter: timeFormatter)
                        Text("$\(String(format: "%.2f", entry.pay))")
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: viewModel.addEntryClicked) {
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
