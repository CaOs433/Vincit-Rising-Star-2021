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
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2009, month: 1, day: 3)
        return calendar.date(from:startComponents)! ... Date()
    }()
    
    var datesOk: Bool {
        return startDate < endDate
    }
    
    var body: some View {
        VStack {
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
            if !datesOk {
                Text("Start date must be before end date!").foregroundColor(.red)
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
