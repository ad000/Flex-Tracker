//
//  csv_to_object.swift
//  Flex Tracker
//
//  Created by Archael dela Rosa on 4/26/23.
//

import Foundation


class CSVConverter {
    let context = PersistenceController.shared.container.viewContext
    
    var headerRow: String = ""
    var data: [Entry] = []
    
    init(_ filePathName: String = "data") {
        let dataString = readFile(filePathName: filePathName)
        data = parseData(dataString)
    }
    
    func readFile(filePathName: String) -> String {
        var data: String = ""
        // Create File Path
        guard let filepath = Bundle.main.path(forResource: filePathName, ofType: "csv") else {
            return data
        }
        // Read into String
        do {
            data = try String(contentsOfFile: filepath)
        } catch {
            print(error)
        }
        return data
    }
    
    func parseData(_ dataString: String) -> [Entry] {
        var array: [Entry] = []
        // Convert to Array (seperate rows by \n
        var dataArray: [String] = dataString.components(separatedBy: "\n")
        headerRow = dataArray.removeFirst()
        
        // Convert Row to Object
        for row in dataArray {
            let columns = row.components(separatedBy: ",")
            if columns.count < headerRow.components(separatedBy: ",").count {continue}
            // Parse Data
            let date: Date = Date().dateStringToDate(dateString: columns[0])!
            let start: Date = Date().timeStringToDate(timeString: columns[1])!
            let end: Date = Date().timeStringToDate(timeString: columns[2])!
            let hours: Double = Date().getHoursFromTimeStrings(start: start.toTimeString(), end: end.toTimeString())
            let pay: Double = Double(columns[5]) ?? 0
            let routeName: String = columns[6]
            let endFinal: Date = Date().timeStringToDate(timeString: columns[7]) ?? end
            let milage: Double = Double(columns[8]) ?? 0
            let milageReturn: Double = Double(columns[9]) ?? 0
            // Create EntryInfo
            let block = BlockEntity(context: context)
            block.id = UUID()
            block.date = date.toDateString()
            block.timeStart = start.toTimeString()
            block.timeEnd = end.toTimeString()
            block.hours = hours
            block.pay = pay
            // Create BlockInfo
            let route = RouteEntity(context: context)
            route.id = block.id
            route.route = routeName
            route.timeEnd = endFinal.toTimeString()
            route.milage = milage
            route.milageReturn = milageReturn
            // Create Entry Object
            let entry = Entry(block: block, route: route)
            
            // Add to List
            array.append(entry)
        }
        return array
    }
    
    
}
