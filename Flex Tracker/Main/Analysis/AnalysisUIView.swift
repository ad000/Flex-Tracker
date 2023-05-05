//
//  AnalysisUIView.swift
//  Flex Tracker
//
//  Created by Archael dela Rosa on 4/27/23.
//

import SwiftUI


// View Model
class AnalysisViewModel: ObservableObject {
    @Published var model: AnalysisModel
    
    init() {
        self.model = AnalysisModel()
    }
    
    func ChangeHour(_ hour: Double) {
        model.setAnalysis(hour)
        print(model.analysis.toString())
    }
}


// View
struct AnalysisUIView: View {
    var testMode: Bool = false
    @ObservedObject var viewModel: AnalysisViewModel = AnalysisViewModel()
    
    @State var analysis: EntryAnalysis = EntryAnalysis()
    @State var selectedHour: Double = 0.0
    @State var hourOptions: [Double] = []
    
    var hourOptionsExist: Bool {
        get {return self.hourOptions.count > 0}
    }
    
    init(test: Bool = false) {
        self.testMode = test
        UpdateHourOptions()
        ChangeAnalysis()
    }
        
        
    func UpdateHourOptions() {
        // Update Options
        hourOptions = viewModel.model.fetchHourOptions()
        if testMode {hourOptions.append(4.0)} // TestMode: add data for preview (for activeView to override inactiveView
        // Reset Selected
        selectedHour = hourOptions.first ?? 0.0
    }
    
    func ChangeAnalysis() {
        viewModel.ChangeHour(selectedHour)
        analysis = viewModel.model.analysis
    }
    
    
    // Body View
    var body: some View {
        ZStack{
            if (hourOptionsExist) {
                activeView
            } else
            {
                inactiveView
            }
        }
        .onAppear {
            UpdateHourOptions()
        }
    }
    
    
    var inactiveView: some View {
        Text("No data to analyze..")
            .foregroundColor(.gray)
    }
    
    
    var activeView: some View {
        VStack {
            HeaderText("Analyze By Hour")
            // Hour
            hourPicker
            
            // Hours
            VStack {
                HStack(alignment: .bottom) {
                    VStack {
                        Text(String(format:"%.1f", analysis.hoursCompletedMin))
                            .font(.system(size: 14))
                        Text("min")
                            .font(.system(size: 12))
                            .fontWeight(.thin)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    VStack {
                        Text(String(format:"%.1f", analysis.hoursCompletedAverage))
                            .font(.system(size: 24))
                        Text("average")
                            .font(.system(size: 12))
                            .fontWeight(.thin)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    VStack {
                        Text(String(format:"%.1f", analysis.hoursCompletedMax))
                            .font(.system(size: 14))
                        Text("max")
                            .font(.system(size: 12))
                            .fontWeight(.thin)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                Text("Completed Hours")
                    .padding(.top, 2)
            }
            .padding(8)
            .background(.tertiary)
            .cornerRadius(8)
            .padding(12)
            
            // Milage
            VStack {
                HStack(alignment: .bottom) {
                    VStack {
                        Text(
                            String(format:"%.0f", analysis.milageMin) +
                            "(" +
                            String(format:"%.0f", analysis.milageReturnMin) + ")"
                        )
                            .font(.system(size: 14))
                        Text("min")
                            .font(.system(size: 12))
                            .fontWeight(.thin)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    VStack {
                        Text(String(format:"%.0f", analysis.milageAverage) +
                             "(" +
                             String(format:"%.0f", analysis.milageReturnAverage) + ")"
                        )
                            .font(.system(size: 24))
                        Text("average")
                            .font(.system(size: 12))
                            .fontWeight(.thin)
                    }
                    .frame(alignment: .center)
                    VStack {
                        Text(String(format:"%.0f", analysis.milageMax) +
                             "(" +
                             String(format:"%.0f", analysis.milageReturnMax) + ")"
                        )
                            .font(.system(size: 14))
                        Text("max")
                            .font(.system(size: 12))
                            .fontWeight(.thin)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                Text("Milage (Return)")
                    .padding(.top, 2)
            }
            .padding(8)
            .background(.tertiary)
            .cornerRadius(8)
            .padding(12)
            
            // Routes
            routeList
            
            Spacer()
        }
        .lineLimit(1)
    }
    
    var hourPicker: some View {
        HStack {
            Text("Hour:")
            Picker("Hour:", selection: $selectedHour) {
                ForEach(hourOptions, id: \.self) { item in
                    Text(String(format:"%.1f", item))
                }
            }
            .onChange(of: selectedHour) { _ in
                ChangeAnalysis()
            }
            .onAppear() {
                ChangeAnalysis()
            }
            
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(.tertiary)
        .cornerRadius(8)
        .padding(12)
    }
    
    
    var routeList: some View {
        VStack {
            List {
                ForEach(analysis.routes.sorted(by: <), id: \.key) { route, count in
                    HStack{
                        Text(route)
                            .font(.system(size: 14))
                        Spacer()
                        Text(String(count))
                            .font(.system(size: 14))
                        Text(String(viewModel.model.getRoutePercent(route: route))+"%")
                            .font(.system(size: 14))
                        
                    }
                }
            }
            .cornerRadius(4)
            Text("Routes")
        }
        .padding(8)
        .background(.tertiary)
        .cornerRadius(8)
        .padding(12)
    }
}


// DataCell View
private struct DataCell: View {
    @State var title: String
    @State var min: String
    @State var max: String
    @State var avg: String
    
    init(title: String, min: String, max: String, avg: String) {
        self.title = title
        self.min = min
        self.max = max
        self.avg = avg
    }
    
    var body: some View {
        VStack {
            // Data
            HStack(alignment: .bottom) {
                VStack {
                    Text(min)
                        .font(.system(size: 14))
                    Text("min")
                        .font(.system(size: 12))
                        .fontWeight(.thin)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                VStack {
                    Text(avg)
                        .font(.system(size: 24))
                    Text("average")
                        .font(.system(size: 12))
                        .fontWeight(.thin)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                VStack {
                    Text(max)
                        .font(.system(size: 14))
                    Text("max")
                        .font(.system(size: 12))
                        .fontWeight(.thin)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            Text(title)
                .padding(.top, 2)
        }
        .padding(8)
        .background(.tertiary)
        .cornerRadius(8)
        .padding(12)
    }
}


struct AnalysisUIView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisUIView(test: true)
    }
}
