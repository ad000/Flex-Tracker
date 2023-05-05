//
//  EntriesModel-Patches.swift
//  Flex Tracker
//
//  Created by Archael dela Rosa on 4/27/23.
//

import Foundation
import CoreData


extension EntriesModel {
    
    
    private func patchInData() {
        /*  Patch Data via CSV
            If there are no entries, load in data from csv file
         */
        if (entryList.count == 0) {
            print("Patching in data set from CSV..")
            let converter = CSVConverter("data")
            for entry in converter.data {
                entryList.add(entry: entry)
            }
            save()
        }
    }
    
}
