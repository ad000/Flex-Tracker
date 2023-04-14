//
//  Delivery_Gig_TrackerApp.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 3/29/23.
//

import SwiftUI

@main
struct Delivery_Gig_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainUIView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
