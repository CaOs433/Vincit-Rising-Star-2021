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
    
    /// Possible API Server error
    @State private var apiError: APIError?
    
    /// Start date for the fetch
    @State private var startDate: Date = Date(timeIntervalSince1970: 1638316800)
    /// End date for the fetch
    @State private var endDate: Date = Date()
    
    @State private var loading: Bool = false
    
    /// Last selected coin name from User Defaults
    @AppStorage("coinName") private var coinName = "Bitcoin"
    /// Last selected coin id from User Defaults
    @AppStorage("coin") private var coin = "bitcoin"
    /// Last selected vs_currency from User Defaults
    @AppStorage("currency") private var currency = "eur"
    
    // Is the date inputs ok
    var inputOk: Bool {
        // Today
        let now = Date()
        // Is the start date after end date or are the dates in future
        if startDate>=endDate || now < startDate || now < endDate || startDate.strValShort == endDate.strValShort {
            return false
        }
        // All ok
        return true
    }
    
    var body: some View {
        VStack {
            // Current coin
            Text(coinName).font(.title2).fontWeight(.semibold)
            
            // Input:
            InputView(startDate: $startDate, endDate: $endDate)
            
            // Update button
            Button("Update", action: update).font(.title2).disabled(loading || !inputOk)
            
            // Loading circle
            if self.loading {
                ProgressView().progressViewStyle(.circular)
            }
            
            // Output:
            if assignments != nil && inputOk {
                OutputView(assignments: $assignments, startDate: $startDate, endDate: $endDate)
            } else if self.apiError != nil {
                APIErrorView(apiError: $apiError)
                    .padding(10)
            }
            
            Spacer()
            
        }.padding()
    }
    
    /// Update data
    func update() {
        // Is the start date before end date?
        if startDate < endDate {
            // Execute on background
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    // Execute on main
                    DispatchQueue.main.async {
                        self.loading = true
                    }
                    print("startDate.timeIntervalSince1970: ", startDate.timeIntervalSince1970)
                    print("endDate.timeIntervalSince1970: ", endDate.timeIntervalSince1970)
                    print("startDate.strVal: ", startDate.strValShort)
                    print("endDate.strVal: ", endDate.strValShort)
                    
                    // Fetch and parse data
                    self.assignments = try Assignments(from: Int(startDate.timeIntervalSince1970), to: Int(endDate.timeIntervalSince1970), coin: coin, vs_currency: currency)
                    // Erase any possible old error
                    self.apiError = nil
                    
                } catch let error as APIError {
                    // Server returned an error - save it to show description for the user
                    self.apiError = error
                    
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
