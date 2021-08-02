//
//  ObjectModel.swift
//  Countdown-macOS
//
//  Created by Scott D. Bowen on 2/8/21.
//

import Foundation

class ObjectModel: ObservableObject {
    
    @Published var september: September1st
    
    init() {
        self.september = September1st(dayOfMonth: 7)
    }
}
