//
//  BlockInfoCellUIView.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/17/23.
//

import SwiftUI

struct BlockInfoCellUIView: View {
    @ObservedObject var entry: Entry
    
    let isCurrentDate: Bool
    @State var fontColor: Color = Color.primary
    @State var dateColor: Color = Color.primary
    
    @State var date: String = ""
    @State var time: String = ""
    @State var hours: Double = 0
    @State var pay: Double = 0
    @State var route: String = ""
    
    init(entry: Entry) {
        self.entry = entry
        self.isCurrentDate = entry.date == Date().toDateString()
        loadEntryData()
    }
    
    func loadEntryData() {
        date = entry.date
        time = entry.timeStart
        hours = entry.hours
        pay = entry.pay
        route = entry.routing
        // UI
        fontColor =
            (entry.isCompleted) ?
            Color.secondary :
            Color.primary
        dateColor =
            (isCurrentDate && !entry.isCompleted) ?
            Color.blue : fontColor
    }
    
    var body: some View {
        GeometryReader { metrics in
            HStack(spacing:0){
                Text(date)
                    .foregroundColor(dateColor)
                    .fontWeight(.semibold)
                    .frame(width: metrics.size.width * 0.14, height: metrics.size.height, alignment: .leading)
                    .padding(.horizontal, 4)
                
                Text(time)
                    .frame(width: metrics.size.width * 0.14, height: metrics.size.height, alignment: .leading)
                    .padding(.horizontal, 2)
                
                Text( "\(String(format:"%.1f", hours)) hr" )
                    .frame(width: metrics.size.width * 0.18, height: metrics.size.height, alignment: .leading)
                    .padding(.horizontal, 4)
                
                Text("$\(String(format: "%.2f", pay))")
                    .frame(width: metrics.size.width * 0.18, height: metrics.size.height, alignment: .leading)
                    .padding(.horizontal, 4)
                
                Text(route)
                    .frame(width: metrics.size.width * 0.36, height: metrics.size.height, alignment: .leading)
                    .padding(.horizontal, 4)
                
            }
            .lineLimit(1)
            .font(.system(size: 13))
            .foregroundColor(fontColor)
        }
        
        .onAppear() {loadEntryData()}
    }
}

struct BlockInfoCellUIView_Previews: PreviewProvider {
    static var previews: some View {
        BlockInfoCellUIView(entry: EntriesModel().createEntry(date: Date(), start: Date(), end: Date(), pay: 0))
    }
}
