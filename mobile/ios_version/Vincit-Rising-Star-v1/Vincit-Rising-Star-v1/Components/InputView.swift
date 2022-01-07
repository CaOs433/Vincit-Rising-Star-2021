//
//  InputView.swift
//  Vincit-Rising-Star-v1
//
//  Created by Oskari Saarinen on 28.12.2021.
//

import SwiftUI

/// View for input dates
struct InputView: View {
    
    /// Start date for the range
    @Binding var startDate: Date
    /// End date for the range
    @Binding var endDate: Date
    
    /// Date range to limit selectable dates (from Bitcoin's launch date to today)
    let dateRange: ClosedRange<Date> = {
        /*let calendar = Calendar.current
        let startComponents = DateComponents(year: 2009, month: 1, day: 3)
        return calendar.date(from:startComponents)! ... Date()*/
        
        return Date(timeIntervalSince1970: 1230940800) ... Date()
    }()
    
    /// Date range errors
    enum DatesError {
        case notInRange, inFuture
        
        var error: String {
            if self == .notInRange {
                return "Start date must be before end date!"
            } else if self == .inFuture {
                return "Dates can't be in the future!"
            }
            
            return ""
        }
    }
    
    // Array of date range errors if any
    var datesOk: [DatesError] {
        // Today
        let now = Date()
        
        // Array for errors
        var errors: [DatesError] = []
        
        // Is start or end date in future?
        if now < startDate || now < endDate {
            errors.append(.inFuture)
        }
        // Is the start date after end date?
        if startDate >= endDate || startDate.strValShort == endDate.strValShort {
            errors.append(.notInRange)
        }
        
        return errors
    }
    
    /// Get timezone of UTC
    func getTimeZone() -> TimeZone? {
        guard let tz = TimeZone(identifier: "UTC") else {
            print("Couldn't make timezone from 'UTC'")
            return nil
        }
        
        print("Timezone 'UTC'")
        return tz
    }
    
    var body: some View {
        VStack {
            if let tz = getTimeZone() {
                // Picker for start date
                DatePicker(
                    selection: $startDate,
                    in: dateRange,
                    displayedComponents: [.date],
                    label: { Text("Start Date") }
                ).environment(\.timeZone, tz)
                // Picker for end date
                DatePicker(
                    selection: $endDate,
                    displayedComponents: [.date],
                    label: { Text("End Date") }
                ).environment(\.timeZone, tz)
            } else {
                // Picker for start date
                DatePicker(
                    selection: $startDate,
                    in: dateRange,
                    displayedComponents: [.date],
                    label: { Text("Start Date") }
                )
                // Picker for end date
                DatePicker(
                    selection: $endDate,
                    displayedComponents: [.date],
                    label: { Text("End Date") }
                )
            }
            
            ForEach(datesOk, id: \.self) { err in
                Text(err.error).foregroundColor(.red)
            }
        }.padding()
            .background(Color.blue.opacity(0.04))
    }
}

/*struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}*/
