//
//  UIElements.swift
//  Delivery Gig Tracker
//
//  Created by Archael dela Rosa on 4/26/23.
//

import SwiftUI

// Header Text Element
struct HeaderText: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .fontWeight(.thin)
            .font(.system(size: 20))
    }
}



//struct UIElements_Previews: PreviewProvider {
//    static var previews: some View {
//        UIElements()
//    }
//}
