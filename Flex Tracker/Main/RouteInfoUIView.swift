//
//  RouteInfoUIView.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/17/23.
//

import SwiftUI

struct RouteInfoUIView: View {
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var entry: Entry
    
    @State var route: String = ""
    @State var timeEnd: Date = Date()
    @State var milage: Double = 0
    @State var milageReturn: Double = 0
    
    init(entry: Entry) {
        self.entry = entry
        loadEntryData()
    }
    
    func loadEntryData() {
        route = entry.route.route ?? ""
        milage = entry.route.milage
        milageReturn = entry.route.milageReturn
        if let timeString : String = entry.route.timeEnd {
            timeEnd = Date().timeStringToDate(timeString: timeString)!
        }
        else {
            timeEnd = Date()
        }
    }
    
    func updateEntry() {
        entry.route.route = route
        entry.route.timeEnd = timeEnd.toTimeString()
        entry.route.milage = milage
        entry.route.milageReturn = milageReturn
        // Save
        entry.save()
    }
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HeaderText("Full Route Information")
                    blockUI
                    routeUI
                    Spacer()
                }
                .onAppear() {loadEntryData()}
            }
            
        }
    }
    
    var blockUI: some View {
        VStack {
            // Input Stack
            HStack {
                // Date Input
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date:")
                        .bold()
                    Text(entry.date)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.black, lineWidth: 1)
                )
                // Pay Input
                VStack(alignment: .leading, spacing: 4) {
                    Text("Pay:")
                        .bold()
                    Text("$\(String(format: "%.2f", entry.pay))")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.black, lineWidth: 1)
                )
            }
            HStack {
                // Time Start Input
                VStack(alignment: .leading, spacing: 4) {
                    Text("Time Start:")
                        .bold()
                    Text(entry.timeStart)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.black, lineWidth: 1)
                )
                // Time End Input
                VStack(alignment: .leading, spacing: 4) {
                    Text("Time End:")
                        .bold()
                    Text(entry.timeEnd)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.black, lineWidth: 1)
                )
            }
            
        }
        .foregroundColor(.gray)
        .padding()
    }
    
    var routeUI: some View {
        VStack {
            // Route
            VStack(alignment: .leading, spacing: 4) {
                Text("Route")
                    .bold()
                TextField("", text: $route)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(4)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.black, lineWidth: 1)
            )
            // End Time
            VStack(alignment: .leading, spacing: 4) {
                Text("Time End:")
                    .bold()
                DatePicker(
                    "",
                    selection: $timeEnd,
                    displayedComponents: .hourAndMinute
                )
                .labelsHidden()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(4)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.black, lineWidth: 1)
            )
            HStack {
                // Milage
                VStack(alignment: .leading, spacing: 4) {
                    Text("Milage:")
                        .bold()
                    TextField("0.00", value: $milage, format: .number) .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.black, lineWidth: 1)
                )
                // Return Distance (Home/Warehouse)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Milage (Return):")
                        .bold()
                    TextField("0.00", value: $milageReturn, format: .number) .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.black, lineWidth: 1)
                )
            }
            Spacer()
            // Buttons
            HStack {
                Button {
                    // Onclick: Update Entry and Rollback to View
                    updateEntry()
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Label("Save", systemImage: "plus")
                }
            }
        }
        .padding()
    }
}

struct RouteInfoUIView_Previews: PreviewProvider {
    static var previews: some View {
        RouteInfoUIView(
            entry: EntriesModel(test: true)
                .createEntry(date: Date(), start: Date(), end: Date(), pay: 0))
    }
}
