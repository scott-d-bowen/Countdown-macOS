//
//  ContentView.swift
//  Countdown-macOS
//
//  Created by Scott D. Bowen on 2/8/21.
//
import SwiftUI


struct ContentView: View {
    
    @StateObject var objectModel = ObjectModel()
    
    @ObservedObject var september1st = September1st(dayOfMonth: 1)
    
    @State var currentDate = Date()
    @State var timeRemainingString: String = "..."
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var countDownUntilText: String?
    
    init() {
        september1st = September1st(dayOfMonth: 1)
    }
    
    var body: some View {
        VStack {
            Divider()
            Text("Current Date and Time:")
                .bold()
            Text("\(currentDate)")
                .onReceive(timer) { input in
                    currentDate = input
                    timeRemainingString = buildTimeRemainingString(futuredate: September1st.date(dayOfMonth: 1), currentDate: currentDate, secondsRemaining: UInt64(DateInterval(start: currentDate, end: September1st.date(dayOfMonth: 1)).duration ))
            }
            Divider()
            CountdownUntil() // (countDownUntilText: countDownUntilText)
            Divider()
            Text("Time remaining:")
                .bold()
            Text("\(timeRemainingString)")
            Divider()
        }
        .font(.largeTitle)
        .environmentObject(objectModel)
    }
}

struct CountdownUntil: View {
    
    @EnvironmentObject var objectModel: ObjectModel
    
    var days = [1, 7, 14]
    @State private var selectedDay = 1

    var body: some View {
        VStack {
            Picker("Please choose a day", selection: $selectedDay) {
                ForEach(days, id: \.self) { idx in
                    Text("\(idx): \(selectedDay.description)")
                }
            }
            Text("You selected: \(selectedDay)")
            Text(objectModel.september.setAndGetCountDownUntilText(dayOfMonth: selectedDay))
        }
        // .environmentObject(objectModel)
    }
}

struct CountdownUntil__OLD: View {
    
    @ObservedObject var objectModel: ObjectModel = ObjectModel()
    private var days = [1, 7, 14]
    @State private var selectedDay = 1
    
    var body: some View {
        VStack {
            Text("Counting down until:")
                .bold()
            Picker("Picker", selection: $selectedDay) {
                ForEach(days, id: \.self) { _ in
                    //, id: \.self) { _ in // days in
                    Text("\(selectedDay)")
                }
            }
            Text(objectModel.september.setAndGetCountDownUntilText(dayOfMonth: selectedDay))
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
