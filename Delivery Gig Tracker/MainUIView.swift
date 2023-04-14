//
//  MainUIView.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/14/23.
//

import SwiftUI


struct MainUIView: View {
    // View Model
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            // Entry List
            VStack {
                // ENTRY ITEM
                HStack {
                    Text("DATE")
                    Text("START")
                    Text("ENDTIME")
                    Text("HOURS")
                    Text("PAY")
                    Text("ROUTE")
                }
            }
            
            // Edit Bar
            Button("ADD ENTRY", action: viewModel.addEntryClicked)
            
            // Selected Entry View
            VStack {
                Text("ROUTE")
                Text("ENDTIME")
                HStack {
                    Text("MILAGE")
                    Text("RETURN")
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
