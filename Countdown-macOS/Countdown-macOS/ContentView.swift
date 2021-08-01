//
//  ContentView.swift
//  Countdown-macOS
//
//  Created by Scott D. Bowen on 2/8/21.
//

import SwiftUI

// var september1st = Calendar(identifier: .gregorian).date(from: September1st().dateComponents )
var september1st = September1st()
var september1stText = september1st.dateFormatter.string(from: september1st.date() )

struct ContentView: View {
    
    @State var currentDate = Date()
    @State var timeRemainingString: String = "..."
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Divider()
            Text("Current Date and Time:")
                .bold()
            Text("\(currentDate)")
                .onReceive(timer) { input in
                    currentDate = input
                    timeRemainingString = buildTimeRemainingString(futuredate: september1st.date(), currentDate: currentDate, secondsRemaining: UInt64(DateInterval(start: currentDate, end: september1st.date()).duration ))
            }
            Divider()
            CountdownUntil()
            Divider()
            Text("Time remaining:")
                .bold()
            Text("\(timeRemainingString)")
            Divider()
        }
        .font(.largeTitle)
    }
}


struct CountdownUntil: View {
    var body: some View {
        VStack {
            Text("Counting down until:")
                .bold()
            Text("\(september1stText)")
        }
    }
}

func buildTimeRemainingString(futuredate: Date, currentDate: Date, secondsRemaining: UInt64) -> String {
    
    let intermediateSecondsRemaining = secondsRemaining
    
    var timeRemainingString: String = timeRemainingDays(futuredate: futuredate, currentDate: currentDate).description
    timeRemainingString += " days "
    
    let hoursRemaining = intermediateSecondsRemaining / (60 * 60) % (24)
    
    timeRemainingString += (hoursRemaining).description
    timeRemainingString += " hours "
    
    let minutesRemaining = intermediateSecondsRemaining / (60) % 60
    
    timeRemainingString += (minutesRemaining).description
    timeRemainingString += " minutes "
    
    let secondsRemaining = intermediateSecondsRemaining % (60)
    
    timeRemainingString += (secondsRemaining).description
    timeRemainingString += " seconds"
    
    return timeRemainingString
}

func timeRemainingDays(futuredate: Date, currentDate: Date) -> UInt64 {
    let days: UInt64 = UInt64(DateInterval(start: currentDate, end: futuredate).duration ) / 3600 / 24
    return days
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
