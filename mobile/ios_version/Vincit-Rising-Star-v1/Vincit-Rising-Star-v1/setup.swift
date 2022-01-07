//
//  setup.swift
//  Vincit-Rising-Star-v1
//
//  Created by Oskari Saarinen on 27.12.2021.
//

import SwiftUI

extension UIColor {
    /// Get color from hex string
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        // If the string starts with #
        if hex.hasPrefix("#") {
            /// Index after #
            let start = hex.index(hex.startIndex, offsetBy: 1)
            /// The string without the #
            let hexColor = String(hex[start...])
            
            // Does the string contains 6 or 8 chars (R, G, B & Alpha)?
            if hexColor.count == 6 || hexColor.count == 8 {
                /// Value with alpha
                let hexC = (hexColor.count == 8) ? hexColor : "\(hexColor)FF"
                
                let scanner = Scanner(string: hexC)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

extension Date {
    /// Date to string value (in UTC)
    public var strVal: String {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeZone = TimeZone(identifier: "UTC")
        return f.string(from: self)
    }
    
    /// Date to string value in short format (in UTC)
    public var strValShort: String {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeZone = TimeZone(identifier: "UTC")
        return f.string(from: self)
    }
}

extension Double {
    /// Double to string value
    public var strValue: String {
        return String(self)
    }
}

/// Now you can throw a string directly without needing to use error class
extension String: Error {}

/*extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return self.hash
    }
}*/
