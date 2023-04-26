//
//  BlockCreationUIView.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/17/23.
//

import SwiftUI

struct BlockCreationUIView: View {
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var viewModel: ViewModel
    @State var date: Date = Date()
    @State var timeStart: Date = Date()
    @State var timeEnd: Date = Date()
    @State var pay: Double = 0
    
    @State private var showingAlert = false
    @State private var errorMesage: String = ""
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    func CreateEntryClicked() {
        // confirm inputs filled
        errorMesage = ""
        if (pay <= 0) {
            errorMesage += "Pay: missing amount\n"
        }
        if (timeEnd.toTimeString() == timeStart.toTimeString()) {
            errorMesage += "End Time: is equal to start time\n"
        }
        // Alert
        if (errorMesage.count > 0) {
            showingAlert = true
            return
        }
        // Add Entry
        viewModel.addEntryClicked(date: date, start: timeStart, end: timeEnd, pay: pay)
        // Segue
        self.presentation.wrappedValue.dismiss()
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                // Label
                HeaderText("Create New Block")
                // Input Stack
                HStack {
                    // Date Input
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Date:")
                            .bold()
                        DatePicker("",
                            selection: $date,
                            displayedComponents: .date
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .labelsHidden()
                        
                    }
                    .padding(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.black, lineWidth: 1)
                    )
                    // Pay Input
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Pay:")
                            .bold()
                        TextField("0.00", value: $pay, format: .number) .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
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
                        DatePicker(
                            "",
                            selection: $timeStart,
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
                    // Time End Input
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
                    
                }
                Spacer()
                
            }
            .padding()
            .toolbar {
                ToolbarItem {
                    Button {
                        CreateEntryClicked()
                    } label: {
                        Label("Create Entry", systemImage: "plus")
                    }
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Problem Creating Entry"),
                message: Text(errorMesage),
                dismissButton: .cancel()
            )
        }
    }
}

struct BlockCreationUIView_Previews: PreviewProvider {
    static var previews: some View {
        BlockCreationUIView(viewModel: ViewModel())
    }
}
