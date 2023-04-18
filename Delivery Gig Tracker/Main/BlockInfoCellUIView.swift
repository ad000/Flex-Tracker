//
//  BlockInfoCellUIView.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/17/23.
//

import SwiftUI

struct BlockInfoCellUIView: View {
    @ObservedObject var entry: Entry
    
    @State var date: String = ""
    @State var time: String = ""
    @State var hours: Double = 0
    @State var pay: Double = 0
    @State var route: String = ""
    
    init(entry: Entry) {
        self.entry = entry
        loadEntryData()
    }
    
    func loadEntryData() {
        date = entry.date
        time = entry.timeStart
        hours = entry.hoursBlock
        pay = entry.pay
        route = entry.routing
    }
    
    var body: some View {
        HStack {
            Text(date)
            Text(time)
            Text(String(hours) )
            Text("$\(String(format: "%.2f", pay))")
            Text(route)
        }
        .onAppear() {loadEntryData()}
    }
}

struct BlockInfoCellUIView_Previews: PreviewProvider {
    static var previews: some View {
        BlockInfoCellUIView(entry: EntriesModel().createEntry(date: Date(), start: Date(), end: Date(), pay: 0))
    }
}
