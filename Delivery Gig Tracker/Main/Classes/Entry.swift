//
//  Entry.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/17/23.
//

import Foundation

// Object holding entry data
class Entry: ObservableObject {
    var id: UUID
    var block: BlockInfo
    var route: RouteInfo
    
    var date: Date {
        get { return block.date! }
    }
    
    var timeStart: Date {
        get { return block.timeStart!}
    }
    
    var timeEnd: Date {
        get { return block.timeEnd!}
    }
    
    var pay: Double {
        get { return block.pay }
    }
    
    
    init(block: BlockInfo, route: RouteInfo) {
        self.block = block
        self.route = route
        self.id = block.id!
    }
    
}
