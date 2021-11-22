//
//  HighlightSyntaxStringExtension.swift
//  ReplitCodingApp
//
//  Created by user on 11/22/21.
//

import Foundation
import SwiftUI

extension String {
    func highlightSyntax(font: UIFont) -> NSMutableAttributedString {
        let highlightDict : [String: UIColor] = ["def": SyntaxColors.blue,
                                                 "class": SyntaxColors.blue,
                                                 "print": SyntaxColors.yellow,
                                                 "function": SyntaxColors.yellow,
                                                 "comment": SyntaxColors.green]
        
        let stringRange = NSRange(location: 0, length: self.count)
        
        let finalAttributedString = NSMutableAttributedString.init(string: self)
        finalAttributedString.addAttribute(NSAttributedString.Key.font, value: font, range: stringRange)
        finalAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: stringRange)

        let lines = self.components(separatedBy: "\n")
        
        for lineNum in 0..<lines.count {
            let line = lines[lineNum]
            let words = line.components(separatedBy: " ")

            let previousLineLength = lineNum == 0 ? 0 : lines[lineNum - 1].count
            for word in words {
                if let color = highlightDict[word] {
                    let rangeInCurrentLine = (line as NSString).range(of: word)
                    let rangeLocation = lineNum + previousLineLength + rangeInCurrentLine.location
                    let range = NSRange(location: rangeLocation, length: rangeInCurrentLine.length)
                    print("RangeInCurrentLine: \(rangeInCurrentLine)\nPreviousLineRange: \(previousLineLength)\nRange: \(range)")
                    finalAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
                }
            }
        }

        return finalAttributedString
    }
}

struct SyntaxColors {
    static var green = UIColor(red: 84/255, green: 128/255, blue: 73/255, alpha: 1.0)
    static var blue = UIColor(red: 59/255, green: 147/255, blue: 205/255, alpha: 1.0)
    static var lightBlue = UIColor(red: 93/255, green: 168/255, blue: 215/255, alpha: 1.0)
    static var yellow = UIColor(red: 217/255, green: 214/255, blue: 164/255, alpha: 1.0)
    static var orange = UIColor(red: 205/255, green: 133/255, blue: 111/255, alpha: 1.0)
    static var lightGreen = UIColor(red: 172/255, green: 199/255, blue: 161/255, alpha: 1.0)
    static var brightGreen = UIColor(red: 22/255, green: 194/255, blue: 168/255, alpha: 1.0)
}
