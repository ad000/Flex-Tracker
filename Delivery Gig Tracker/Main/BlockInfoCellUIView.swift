//
//  BlockInfoCellUIView.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/17/23.
//

import SwiftUI

struct BlockInfoCellUIView: View {
    var entry: Entry
    
//    private let dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        return formatter
//    }()
//    private let timeFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.timeStyle = .short
//        return formatter
//    }()
//
    
    var body: some View {
        NavigationLink {
            // TODO REMOVE
            Text("Block at \(entry.date)")
        } label: {
            Text(entry.date)
            Text(entry.timeStart)
            Text(String(entry.hoursBlock) ?? "")
            Text("$\(String(format: "%.2f", entry.pay))")
        }
//        .padding(8)
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .foregroundColor(Color.black)
//        .background(Color.white)
//        .cornerRadius(4)
    }
}

struct BlockInfoCellUIView_Previews: PreviewProvider {
    static var previews: some View {
        BlockInfoCellUIView(entry: EntriesModel().createEntry(date: Date(), start: Date(), end: Date(), pay: 0))
    }
}
