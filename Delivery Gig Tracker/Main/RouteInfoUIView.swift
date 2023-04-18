//
//  RouteInfoUIView.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/17/23.
//

import SwiftUI

struct RouteInfoUIView: View {
    @State var route: String = ""
    @State var timeEnd: Date = Date()
    @State var milage: Double = 0
    @State var milageReturn: Double = 0
    
    
    var body: some View {
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
        }
        .padding()
    }
}

struct RouteInfoUIView_Previews: PreviewProvider {
    static var previews: some View {
        RouteInfoUIView()
    }
}
