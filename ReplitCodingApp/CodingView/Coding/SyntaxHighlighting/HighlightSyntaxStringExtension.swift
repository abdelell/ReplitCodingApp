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
                                                 "string": SyntaxColors.orange,
                                                 "function": SyntaxColors.yellow,
                                                 "comment": SyntaxColors.green,
                                                 "parameter": SyntaxColors.lightBlue,
                                                 "className": SyntaxColors.brightGreen,
                                                 "return": SyntaxColors.blue]
        
        let stringRange = NSRange(location: 0, length: self.count)
        
        let finalAttributedString = NSMutableAttributedString.init(string: self)
        finalAttributedString.addAttribute(NSAttributedString.Key.font, value: font, range: stringRange)
        finalAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: stringRange)

        let lines = self.components(separatedBy: "\n")
        
        var previousLength = 0
        
        for lineNum in 0..<lines.count {
            let line = lines[lineNum]
            let lineWithoutSpacing = line.trimmingCharacters(in: .whitespaces)
            
            var checkForColon = false
            var checkForString = true
            
            let previousLinesLength = previousLength
            // Need to put it before the if statment in case something falls through
            previousLength += line.count
            
            if lineWithoutSpacing.hasPrefix("#") {
                // Color comments
                let commentRange = NSRange(location: previousLinesLength + lineNum, length: line.count)
                finalAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightDict["comment"] ?? .yellow, range: commentRange)
                
                checkForString = false
            } else if lineWithoutSpacing.hasPrefix("def ") {
                // Assigning color for functions
                let defRangeInCurrentLine = (line as NSString).range(of: "def ")
                let defRange = NSRange(location: previousLinesLength + lineNum + defRangeInCurrentLine.location, length: defRangeInCurrentLine.length)
                finalAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightDict["def"] ?? .yellow, range: defRange)
                
                guard let functionName = line.slice(from: "def ", to: "(") else {
                    continue
                }
                
                let functionRangeInCurrentLine = (line as NSString).range(of: functionName)
                let functionNameRange = NSRange(location: previousLinesLength + lineNum + functionRangeInCurrentLine.location, length: functionRangeInCurrentLine.length)
                finalAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightDict["function"] ?? .yellow, range: functionNameRange)
                
                // Assigning color to parameters
                guard let params = line.slice(from: "(", to: ")"), params.count > 0 else {
                    continue
                }

                for param in params.components(separatedBy: ",") {
                    
                    guard param != "" else {
                        continue
                    }
                    
                    // Have to use backwards search in case the function name is the same as the paramater name
                    let paramRangeInCurrentLine = (line as NSString).range(of: param, options: .backwards)
                    let paramRange = NSRange(location: previousLinesLength + lineNum + paramRangeInCurrentLine.location, length: paramRangeInCurrentLine.length)
                    finalAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightDict["parameter"] ?? .yellow, range: paramRange)
                }
                
                checkForColon = true
            } else if lineWithoutSpacing.hasPrefix("print") {
                
                let printRangeInCurrentLine = (line as NSString).range(of: "print")
                let printRange = NSRange(location: previousLinesLength + lineNum + printRangeInCurrentLine.location, length: printRangeInCurrentLine.length)
                finalAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightDict["print"] ?? .yellow, range: printRange)
                
            } else if lineWithoutSpacing.hasPrefix("return ") {
                
                let returnRangeInCurrentLine = (line as NSString).range(of: "return ")
                let returnRange = NSRange(location: previousLinesLength + lineNum + returnRangeInCurrentLine.location, length: returnRangeInCurrentLine.length)
                finalAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightDict["return"] ?? .yellow, range: returnRange)

            } else if lineWithoutSpacing.hasPrefix("class ") {
                
                let classRangeInCurrentLine = (line as NSString).range(of: "class ")
                let classRange = NSRange(location: previousLinesLength + lineNum + classRangeInCurrentLine.location, length: classRangeInCurrentLine.length)
                finalAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightDict["class"] ?? .yellow, range: classRange)
                
                var className = ""
                
                if line.contains("(") && line.contains(")") {
                    guard let name = line.slice(from: "class ", to: "(") else {
                        continue
                    }
                    
                    className = name
                } else {
                    guard let name = line.slice(from: "class ", to: ":") else {
                        continue
                    }
                    
                    className = name
                }
                
                
                let classNameRangeInCurrentLine = (line as NSString).range(of: className)
                let classNameRange = NSRange(location: previousLinesLength + lineNum + classNameRangeInCurrentLine.location, length: classNameRangeInCurrentLine.length)
                finalAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightDict["className"] ?? .yellow, range: classNameRange)
                
                checkForColon = true
                
            }
            
            if checkForColon && line.contains(":") {
                let colonRangeInCurrentLine = (line as NSString).range(of: ":")
                let colonRange = NSRange(location: previousLinesLength + lineNum + colonRangeInCurrentLine.location, length: colonRangeInCurrentLine.length)
                finalAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightDict["parameter"] ?? .yellow, range: colonRange)
            }

            // Check if anything is in between quotation marks
            if checkForString && (line.contains("\"") || line.contains("'")) {
                var quotationRanges = [NSRange]()
                
                var isOpenQuotations = false
                var currentOpeningQuotation : Character = Character("'")
                var quotationStartIndex = 0
                for (index, char) in line.enumerated() {
                    let charIsQuotation = (char == "\"" || char == "'")
                    
                    if !isOpenQuotations && charIsQuotation {
                        isOpenQuotations = true
                        currentOpeningQuotation = char
                        quotationStartIndex = index
                    } else if isOpenQuotations && charIsQuotation {
                        if char == currentOpeningQuotation {
                            isOpenQuotations = false
                            let range = NSRange(location: quotationStartIndex + lineNum + previousLinesLength,
                                                length: index - quotationStartIndex + 1)
                            quotationRanges.append(range)
                        }
                    }
                }
                
                if isOpenQuotations {
                    let range = NSRange(location: quotationStartIndex + lineNum + previousLinesLength, length: line.count - quotationStartIndex)
                    quotationRanges.append(range)
                }
                
                quotationRanges.forEach { range in
                    finalAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightDict["string"] ?? .yellow, range: range)
                }
                
                
            }
        }

        return finalAttributedString
    }
}

extension String {
    
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
