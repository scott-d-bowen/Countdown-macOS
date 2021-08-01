//
//  September1st.swift
//  September1st
//
//  Created by Scott D. Bowen on 2/8/21.
//

import Foundation

class September1st {
    
    // Specify date components
    var dateComponents = DateComponents()

    init() {
        dateComponents.year = 2021
        dateComponents.month = 9
        dateComponents.day = 1
        dateComponents.timeZone = TimeZone(abbreviation: "PDT") // Pacific Daylight Time. The Time zone in California, USA (GMT-7)
        dateComponents.hour = 8
        dateComponents.minute = 30
    }
}

