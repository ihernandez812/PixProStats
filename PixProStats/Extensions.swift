//
//  extensions.swift
//  PixProStats
//
//  Created by Isaiah Hernandez on 2/19/25.
//

import Foundation
import SwiftUI

extension Color {
    static let backgroundColor = Color("Background")
    static let iconColor = Color("Icon")
    static let textColor = Color("Text")
    static let rowColor = Color("Row")
    static let fastballColor = Color("Fastball")
    static let curveballColor = Color("Curveball")
    static let changeupColor = Color("Changeup")
    static let systemBackground = Color(uiColor: .systemBackground)
    
    public init(hex: String, opacity: Double = 1.0) {
        var rgbValue:UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        let red = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let green = Double((rgbValue & 0xff00) >> 8) / 255.0
        let blue = Double((rgbValue & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}



extension Double {
    func deleteLeadingZeros() -> String {
        let inputStr = String(self)
        var resultStr = inputStr
        
        while resultStr.hasPrefix("0") && resultStr.count > 1 {
            resultStr.removeFirst()
        }
        return resultStr
    }
}

extension String {
    
    func addTrailingZeros(_ maxLength: Int) -> String {
        var resultStr = self
        guard maxLength > 0 else { return resultStr }
        let count = maxLength - self.count
        if count > 0 {
            resultStr.append(contentsOf: String(repeating: "0", count: count))
        }
        return resultStr
    }
}


extension URL {
    func asyncDownload(completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()) {
        URLSession.shared
            .dataTask(with: self, completionHandler: completion)
            .resume()
    }
}

extension Int {
    func add(num: Int) -> Int{
        return self + num
    }
}
