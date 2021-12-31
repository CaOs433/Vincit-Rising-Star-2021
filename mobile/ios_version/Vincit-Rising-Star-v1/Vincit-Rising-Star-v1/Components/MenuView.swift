//
//  MenuView.swift
//  Vincit-Rising-Star-v1
//
//  Created by Oskari Saarinen on 29.12.2021.
//

import SwiftUI

/// Side Menu view for settings
struct MenuView: View {
    
    /// Core Data view context
    @Environment(\.managedObjectContext) private var viewContext

    /// Coins list fetched from CoreData
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Coin.name, ascending: true)],
        animation: .default
    ) private var coins: FetchedResults<Coin>
    
    /// Last selected coin name from User Defaults
    @AppStorage("coinName") private var coinName = "Bitcoin"
    /// Last selected coin id from User Defaults
    @AppStorage("coin") private var selectedCoin = "bitcoin"
    /// Last selected vs_currency from User Defaults
    @AppStorage("currency") private var selectedCurrency = "eur"
    
    /// Height of this view
    var height: CGFloat
    
    /// List of available vs_currencys in CoinGecko API
    var currencyList = ["btc","eth","ltc","bch","bnb","eos","xrp","xlm","link","dot","yfi","usd","aed","ars","aud","bdt","bhd","bmd","brl","cad","chf","clp","cny","czk","dkk","eur","gbp","hkd","huf","idr","ils","inr","jpy","krw","kwd","lkr","mmk","mxn","myr","ngn","nok","nzd","php","pkr","pln","rub","sar","sek","sgd","thb","try","twd","uah","vef","vnd","zar","xdr","xag","xau","bits","sats"]
    
    /// Default coins in dictionary
    let defaultCoins: [String:String] = [
        "bitcoin":"Bitcoin",
        "ethereum":"Ethereum",
        "litecoin":"Litecoin",
        "dogecoin":"Dogecoin",
        "digibyte":"DigiByte"
    ]
    
    /// Execute when coin is selected from the Picker
    func coinChange(_ tag: String) {
        print("Coin changed to \(tag)")
        
        // Is the selected coin one of the default coins?
        if let name = defaultCoins[tag] {
            // Yes, save it into User Defaults
            self.coinName = name
            print("Coin name: \(name)")
            return
        }
        
        // Find the name of selected coin by id
        for c in coins {
            if c.id == tag {
                // If not nil
                if let name = c.name {
                    // Not nil, save the name into User Defaults
                    self.coinName = name
                    print("Coin name: \(name)")
                }
                return
            }
        }
    }
    
    var body: some View {
        ScrollView {
            // Title
            Text("Settings").font(.title2).fontWeight(.semibold)
            
            Spacer(minLength: 40)
            
            // Picker for vs_currency
            Group {
                Divider()
                
                Text("Currency:").fontWeight(.semibold)
                Picker(selection: $selectedCurrency, label: Text("Currency")) {
                    ForEach(currencyList, id: \.self) { currency in
                        Text(currency)
                    }
                }.frame(minWidth: nil, idealWidth: nil, maxWidth: .infinity, minHeight: nil, idealHeight: nil, maxHeight: nil, alignment: .center)
                    .padding(.horizontal)
                    .background(Color.white.opacity(0.92))
                    .cornerRadius(8)
                    .font(.headline)
            }
            
            Spacer(minLength: 30)
            
            // Picker for coin
            VStack {
                Divider()
                
                Text("Coin:").fontWeight(.semibold)
                Picker(selection: $selectedCoin, label: Text("Crypto Currency")) {
                    // Is there saved coins in Core Data?
                    if coins.count > 0 {
                        ForEach(coins) { coin in
                            if let name = coin.name, let id = coin.id {
                                Text(name).tag(id)
                            } else {
                                Text("-")
                            }
                        }
                    } else {
                        // No, use default coins
                        Text("Bitcoin").tag("bitcoin")
                        Text("Ethereum").tag("ethereum")
                        Text("Litecoin").tag("litecoin")
                        Text("Dogecoin").tag("dogecoin")
                        Text("DigiByte").tag("digibyte")
                    }
                }.frame(minWidth: nil, maxWidth: .infinity,
                        minHeight: nil, maxHeight: nil,
                        alignment: .center)
                    .padding(.horizontal)
                    .background(Color.white.opacity(0.92))
                    .cornerRadius(8)
                    .font(.headline)
                    .onChange(of: selectedCoin, perform: coinChange)
                
                Spacer(minLength: 30)
                
                // Link to coin search view
                NavigationLink(destination: CoinSearchView(defaultCoins: defaultCoins).environment(\.managedObjectContext, viewContext)) {
                    Text("Search more coins")
                        .fontWeight(.semibold)
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            
            Spacer(minLength: 30)
            
            // Licence view link
            Group {
                Divider()
                
                NavigationLink(destination: LicenseView()) {
                    Text("License")
                        .fontWeight(.semibold)
                        .font(.title2)
                        .foregroundColor(.white)
                        .background(Color.black)
                }.frame(minWidth: nil, maxWidth: .infinity,
                        minHeight: nil, maxHeight: nil,
                        alignment: .center)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(8)
            }
            
        }.multilineTextAlignment(.leading)
            .frame(minWidth: 0, maxWidth: .infinity,
                    minHeight: height, maxHeight: height,
                    alignment: .leading)
            .padding()
            .background(Color.black.opacity(0.09))
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(height: 700)
    }
}
