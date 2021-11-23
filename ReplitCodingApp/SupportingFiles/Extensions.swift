//
//  StringExtensions.swift
//  ReplitCodingApp
//
//  Created by user on 11/22/21.
//

import Foundation
import SwiftUI

extension String {
    func sizeOfString(constrainedToWidth width: Double, font: UIFont) -> CGSize {
        return (self as NSString).boundingRect(with: CGSize(width: width, height: Double.greatestFiniteMagnitude),
                                                 options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                 attributes: [NSAttributedString.Key.font: font],
            context: nil).size
    }
    
    func makeItCodeCompatible() -> String {
        return self.replacingOccurrences(of: "“", with: "\"")
            .replacingOccurrences(of: "”", with: "\"")
            .replacingOccurrences(of: "‘", with: "'")
            .replacingOccurrences(of: "’", with: "'")
            .replacingOccurrences(of: "\t", with: "  ")
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
