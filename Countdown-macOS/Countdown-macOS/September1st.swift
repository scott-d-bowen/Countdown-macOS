//
//  September1st.swift
//  September1st
//
//  Created by Scott D. Bowen on 2/8/21.
//
import Foundation

class September1st: ObservableObject {
    
    // Specify date components
    static var dateComponents: DateComponents = DateComponents()
    /* calendar: Calendar(identifier: .gregorian), timeZone: TimeZone(abbreviation: "PDT"), era: 1, year: 2021, month: 9, day: 1, hour: 8, minute: 30, second: 0, nanosecond: 0) // weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil */
    
    static let dateFormatter = DateFormatter()
    
    @Published var countDownUntilText: String = September1st.dateFormatter.string(from: September1st.date(dayOfMonth: 1) )
    
    func setAndGetCountDownUntilText(dayOfMonth: Int) -> String {
        self.countDownUntilText = September1st.dateFormatter.string(from: September1st.date(dayOfMonth: dayOfMonth) )
        return self.countDownUntilText
    }

    init(dayOfMonth: Int) {
        
        September1st.dateFormatter.timeZone = TimeZone(abbreviation: "PDT")
        September1st.dateFormatter.dateStyle = .full
        September1st.dateFormatter.timeStyle = .full
        
        September1st.dateComponents = DateComponents()
        September1st.dateComponents.year = 2021
        September1st.dateComponents.month = 9
        September1st.dateComponents.day = dayOfMonth
        September1st.dateComponents.timeZone = TimeZone(abbreviation: "PDT") // Pacific Daylight Time. The Time zone in California, USA (GMT-7)
        September1st.dateComponents.hour = 8
        September1st.dateComponents.minute = 30
    }
    
    static func date(dayOfMonth: Int) -> Date {
        
        // let initSept1st = September1st(dayOfMonth: dayOfMonth)
        let calendar = Calendar(identifier: .gregorian)
        let retDate = calendar.date(from: self.dateComponents)
        
        return retDate! // .date(from: September1st(dayOfMonth: dayOfMonth).dateComponents )
    }
}
