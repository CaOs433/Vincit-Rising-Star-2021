//
//  CoinList.swift
//  Vincit-Rising-Star-v1
//
//  Created by Oskari Saarinen on 29.12.2021.
//

import Foundation

/// Available coins in CoinGecko
struct CoinList: Codable {
    /// List of the coins
    let list: [Coin]
    
    struct Coin: Codable, Identifiable {
        let id: String
        let symbol: String?
        let name: String?
    }
    
    init(data: Data) throws {
        self.list = try JSONDecoder().decode([Coin].self, from: data)
    }
    
    init() throws {
        if let url = URL(string: "https://api.coingecko.com/api/v3/coins/list") {
            try self.init(data: try Data(contentsOf: url))
        } else {
            throw "Couldn't construct the coin list url"
        }
    }
}
