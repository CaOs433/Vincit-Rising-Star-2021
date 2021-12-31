//
//  CoinSearchView.swift
//  Vincit-Rising-Star-v1
//
//  Created by Oskari Saarinen on 30.12.2021.
//

import SwiftUI

struct CoinSearchView: View {
    
    /// Core Data view context
    @Environment(\.managedObjectContext) private var viewContext

    /// Coins list fetched from CoreData
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Coin.name, ascending: true)],
        animation: .default
    ) private var coins: FetchedResults<Coin>
    
    /// Is the loading in progress
    @State private var loading: Bool = false
    
    /// Coins list from the API
    @State private var fetchedCoins: CoinList? = nil
    
    /// Search text string
    @State private var searchText = ""
    
    /// Hard coded default coins
    let defaultCoins: [String:String]
    
    /// Fetch the data from the API
    func searchCoins() {
        //self.showSearch.toggle()
        if self.fetchedCoins == nil || self.fetchedCoins?.list.count == 0 {
            // Execute on background
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    // Execute on main
                    DispatchQueue.main.async {
                        self.loading = true
                    }
                    self.fetchedCoins = try CoinList()
                } catch {
                    print(error.localizedDescription)
                }
                // Execute on main
                DispatchQueue.main.async {
                    self.loading = false
                }
            }
        }
    }
    
    /// Does coins contains this already
    func coinsContains(c: CoinList.Coin) -> Bool {
        return coins.contains(where: { $0.id == c.id })
    }
    
    /// Save coin into Core Data
    func saveCoin(nCoin: CoinList.Coin) {
        // Save default coins into Core Data
        if coins.count == 0 {
            defaultCoins.forEach { (key: String, value: String) in
                let newCoin = Coin(context: viewContext)
                newCoin.id = key
                newCoin.symbol = key
                newCoin.name = value

                PersistenceController.shared.save()
            }
        }
        // Save the new coin into Core Data if not already in there
        if !coins.contains(where: { $0.id == nCoin.id }) {
            let newCoin = Coin(context: viewContext)
            newCoin.id = nCoin.id
            newCoin.symbol = nCoin.symbol
            newCoin.name = nCoin.name

            PersistenceController.shared.save()
        }
    }
    
    /// Delete coin from Core Data
    func deleteCoin(c: CoinList.Coin) {
        coins.filter { $0.id == c.id }.forEach(viewContext.delete)
    }
    
    /// Delete multiple coins at once
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { coins[$0] }.forEach(viewContext.delete)

            PersistenceController.shared.save()
        }
    }
    
    /// Search results
    var searchResults: [CoinList.Coin] {
        if let list = fetchedCoins?.list {
            if searchText.isEmpty {
                return list
            } else {
                return list.filter { ($0.name ?? "").lowercased().contains(searchText.lowercased()) }
            }
        } else  {
            return []
        }
    }
    
    var searchView: some View {
        VStack {
            if fetchedCoins == nil {
                ProgressView().progressViewStyle(.circular)
            } else {
                // searchable requires atleast iOS 15
                if #available(iOS 15.0, *) {
                    List {
                        ForEach(fetchedCoins!.list) { c in
                            HStack {
                                Text(c.name ?? "-")
                                Spacer()
                                if coinsContains(c: c) {
                                    Button(action: {
                                        deleteCoin(c: c)
                                    }) { Text("Delete") }
                                } else {
                                    Button(action: {
                                        saveCoin(nCoin: c)
                                    }) { Text("Add") }
                                }
                            }.background(Color.black.opacity(0.07))
                        }
                    }.background(Color.blue.opacity(0.07))
                        .searchable(text: $searchText)
                } else {
                    // Fallback on earlier versions
                    List {
                        ForEach(fetchedCoins!.list) { c in
                            HStack {
                                Text(c.name ?? "-")
                                Spacer()
                                if coinsContains(c: c) {
                                    Button(action: {
                                        deleteCoin(c: c)
                                    }) { Text("Delete") }
                                } else {
                                    Button(action: {
                                        saveCoin(nCoin: c)
                                    }) { Text("Add") }
                                }
                            }.background(Color.black.opacity(0.07))
                        }
                    }.background(Color.blue.opacity(0.07))
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            // List of saved coins
            List {
                ForEach(coins) { coin in
                    Text((coin.name ?? coin.id) ?? "-")
                }.onDelete(perform: deleteItems)
            }.navigationBarItems(
                trailing: EditButton().foregroundColor(.white)
            )
            
            // Button for data fetch
            Button("Fetch", action: searchCoins)
            
            if self.loading {
                ProgressView().progressViewStyle(.circular)
            } else {
                if fetchedCoins != nil {
                    // searchable requires atleast iOS 15
                    if #available(iOS 15.0, *) {
                        List {
                            ForEach(searchResults) { c in
                                HStack {
                                    Text(c.name ?? "-").tag(c.name)
                                    Spacer()
                                    if coinsContains(c: c) {
                                        Button(action: {
                                            deleteCoin(c: c)
                                        }) { Text("Delete") }
                                    } else {
                                        Button(action: {
                                            saveCoin(nCoin: c)
                                        }) { Text("Add") }
                                    }
                                }.background(Color.black.opacity(0.07))
                            }
                        }.background(Color.blue.opacity(0.07))
                            .searchable(text: $searchText) {
                                ForEach(searchResults) { c in
                                    HStack {
                                        Text(c.name ?? "-").searchCompletion(c.name ?? "-")
                                        Spacer()
                                        if coinsContains(c: c) {
                                            Button(action: {
                                                deleteCoin(c: c)
                                            }) { Text("Delete") }
                                        } else {
                                            Button(action: {
                                                saveCoin(nCoin: c)
                                            }) { Text("Add") }
                                        }
                                    }.background(Color.black.opacity(0.07))
                                }
                            }
                    } else {
                        // Fallback on earlier versions
                        List {
                            ForEach(searchResults) { c in
                                HStack {
                                    Text(c.name ?? "-")
                                    Spacer()
                                    if coinsContains(c: c) {
                                        Button(action: {
                                            deleteCoin(c: c)
                                        }) { Text("Delete") }
                                    } else {
                                        Button(action: {
                                            saveCoin(nCoin: c)
                                        }) { Text("Add") }
                                    }
                                }.background(Color.black.opacity(0.07))
                            }
                        }.background(Color.blue.opacity(0.07))
                    }
                    /*List {
                        ForEach(fetchedCoins!.list) { c in
                            HStack {
                                Text(c.name ?? "-")
                                Spacer()
                                if coinsContains(c: c) {
                                    Button(action: {
                                        deleteCoin(c: c)
                                    }) { Text("Delete") }
                                } else {
                                    Button(action: {
                                        saveCoin(nCoin: c)
                                    }) { Text("Add") }
                                }
                            }.background(Color.black.opacity(0.07))
                        }
                    }.background(Color.blue.opacity(0.07))*/
                } else {
                    Text("No data")
                }
            }
        }.onAppear(perform: searchCoins)
    }
    
    init(defaultCoins: [String:String]) {
        self.defaultCoins = defaultCoins
    }
}

struct CoinSearchView_Previews: PreviewProvider {
    static var previews: some View {
        CoinSearchView(defaultCoins: [:])
    }
}
