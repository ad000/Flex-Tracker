//
//  MainUIView.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/14/23.
//

import SwiftUI


struct MainUIView: View {
    // View Model
    @MainActor @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderText("Route Tracker")
                
                // Route List
                List {
                    ForEach(viewModel.entriesByCurrentDate.keys.sorted().reversed(), id: \.self) { key in
                        // Sections
                        Section(header: Text(key)) {
                            // Entry Cells
                            ForEach(viewModel.entriesByCurrentDate[key] ?? [], id: \.id) { entry in NavigationLink(
                                        destination: RouteInfoUIView(entry: entry)
                                    ) {
                                        BlockInfoCellUIView(entry: entry)
                                    }
                            }
                            .onDelete { indexSet in
                                if (key == "Today") {
                                    viewModel.deleteCurrentlyActiveEntryClicked(at: indexSet)
                                }
                                else {
                                    viewModel.deleteEntryClicked(at: indexSet)
                                }
                            }
                            // Extra: Load More Button
                            if(key != "Today" && viewModel.canLoadMore) {
                                Button {
                                    viewModel.LoadMoreEntries()
                                } label: {
                                    Text("Load More")
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 16)
                                        .background(.tertiary)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }
                }
                .onAppear(perform: viewModel.updateView)
                
                // Analysis Button
                NavigationLink(
                    destination: AnalysisUIView()
                ) {
                    Text("Analyze Hour")
                        .padding()
                        .background(.tertiary)
                        .clipShape(Capsule())
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

fileprivate struct EntryGroup: Identifiable {
    let id: UUID
    let entries: [Entry]
}

fileprivate extension Sequence {
    func group<Key: Hashable>(by keyPath: KeyPath<Element, Key>) -> [(Key, [Element])] {
        let groups = Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
        return groups.map { (key: $0, value: $1) }
    }
}


struct MainUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainUIView()
    }
}
