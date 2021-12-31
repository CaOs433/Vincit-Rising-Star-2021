//
//  MainView.swift
//  Vincit-Rising-Star-v1
//
//  Created by Oskari Saarinen on 29.12.2021.
//

import SwiftUI

/// Main view
struct MainView: View {
    
    /// Is the settings menu visible
    @Binding var showSettingsMenu: Bool
    
    /// API data from CoinGecko
    @State private var assignments: Assignments?
    
    /// Start date for the fetch
    @State private var startDate: Date = Date()
    /// End date for the fetch
    @State private var endDate: Date = Date()
    
    @State private var loading: Bool = false
    
    /// Last selected coin name from User Defaults
    @AppStorage("coinName") private var coinName = "Bitcoin"
    /// Last selected coin id from User Defaults
    @AppStorage("coin") private var coin = "bitcoin"
    /// Last selected vs_currency from User Defaults
    @AppStorage("currency") private var currency = "eur"
    
    var body: some View {
        VStack {
            // Current coin
            Text(coinName).font(.title2).fontWeight(.semibold)
            
            // Input:
            InputView(startDate: $startDate, endDate: $endDate)
            
            // Update button
            Button("Update", action: update).font(.title2)
            
            // Loading circle
            if self.loading {
                ProgressView().progressViewStyle(.circular)
            }
            
            // Output:
            if assignments != nil {
                OutputView(assignments: $assignments)
            }
            
            Spacer()
            
        }.padding()
    }
    
    /// Update data
    func update() {
        // Is the start date before end date?
        if startDate <= endDate {
            // Execute on background
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    // Execute on main
                    DispatchQueue.main.async {
                        self.loading = true
                    }
                    // Fetch and parse data
                    self.assignments = try Assignments(from: Int(startDate.timeIntervalSince1970), to: Int(endDate.timeIntervalSince1970), coin: coin, vs_currency: currency)
                } catch {
                    // An error occurred, print it into console
                    print(error.localizedDescription)
                }
                // Execute on main
                DispatchQueue.main.async {
                    self.loading = false
                }
            }
        }
    }
    
}

/*struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}*/
