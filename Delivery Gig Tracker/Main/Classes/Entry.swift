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
    var block: BlockEntity
    var route: RouteEntity
    
    var date: String {
        get { return block.date! }
    }
    
    var timeStart: String {
        get { return block.timeStart!}
    }
    
    var timeEnd: String {
        get { return block.timeEnd!}
    }
    
    var pay: Double {
        get { return block.pay }
    }
    
    
    init(block: BlockEntity, route: RouteEntity) {
        self.block = block
        self.route = route
        self.id = block.id!
    }
    
}
