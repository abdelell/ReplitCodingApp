//
//  CustomTextView.swift
//  ReplitCodingApp
//
//  Created by user on 11/18/21.
//

import Foundation
import SwiftUI

struct CodingTextView: UIViewRepresentable {
    
    @Binding var text: String
    @State var lineNumbersText = "1"
    @State var lineNumbersViewHeight = 100.0
    
    var isSelectable: Bool
    
    let font = UIFont(name: "Courier", size: 16)
    
    var lineNumbersView = UITextView()
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.delegate = context.coordinator
        textView.font = font
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.isSelectable = isSelectable
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor(.replitBackgroundColor)
        textView.tintColor = .white
        textView.contentOffset = CGPoint(x: 100.0, y: 0.0)
        textView.textContainerInset = UIEdgeInsets(top: 7, left: 60, bottom: 0, right: 0)
        
        configLineNumbersView()
        textView.addSubview(lineNumbersView)

        let customKeysView = UIHostingController(rootView: CustomKeysView(textView: textView))
        customKeysView.view.frame = CGRect(x: 0, y: 0, width: 10, height: 44)
        customKeysView.view.backgroundColor = UIColor(Color.keyboardDarkBackground)
        textView.inputAccessoryView = customKeysView.view
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        let selectedRange = uiView.selectedRange
        
        let formatTextForCoding = text.replacingOccurrences(of: "“", with: "\"")
            .replacingOccurrences(of: "”", with: "\"")
            .replacingOccurrences(of: "‘", with: "'")
            .replacingOccurrences(of: "’", with: "'")
        uiView.text = formatTextForCoding
        uiView.selectedRange = selectedRange
        
        lineNumbersView.text = lineNumbersText
        lineNumbersView.frame.size.height = lineNumbersViewHeight
        print("Nums: \(self.lineNumbersView.frame.size.height)")
//        lineNumbersView.layoutSubviews()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text, $lineNumbersText, $lineNumbersViewHeight, font!)
    }
     
    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var lineNumbersText: Binding<String>
        var lineNumbersViewHeight: Binding<Double>
        var font: UIFont
     
        init(_ text: Binding<String>,
             _ lineNumbersText: Binding<String>,
             _ lineNumbersViewHeight: Binding<Double>,
             _ font: UIFont) {
            self.text = text
            self.lineNumbersText = lineNumbersText
            self.lineNumbersViewHeight = lineNumbersViewHeight
            self.font = font
        }
        
        func textViewDidChange(_ textView: UITextView) {
            let textLines = textView.text.components(separatedBy: "\n")
            
            var lines = [Int]()
            
            // To calculate the lineNumbersView's height
            var totalNumOfLines = 0
            
            for line in 0..<textLines.count {
                let lineText = textLines[line]
                
                var textWidth = textView.frame.inset(by: textView.textContainerInset).width
                textWidth -= 2.0 * textView.textContainer.lineFragmentPadding
                
                let boundingRect = lineText.sizeOfString(constrainedToWidth: Double(textWidth), font: font)
                
                let numberOfLines = Int(boundingRect.height / textView.font!.lineHeight)
                totalNumOfLines += numberOfLines
                
                lines.append(numberOfLines)
            }
            updateLineNumbers(lines: lines)
            print("Line Nums: \(totalNumOfLines)")
            self.lineNumbersViewHeight.wrappedValue = Double(totalNumOfLines) * 35.0
            
            self.text.wrappedValue = textView.text
        }
        
        private func updateLineNumbers(lines: [Int]) {
            var currentNumber = 1
            var lineNumbers = ""
            
            for numberOfLines in lines {
                
                lineNumbers = "\(lineNumbers)\(currentNumber)\(String(repeating: "\n", count: numberOfLines))"
                currentNumber += 1
            }
    
            lineNumbersText.wrappedValue = lineNumbers
        }
    }
}


// UI Configurations
extension CodingTextView {
    
    private func configLineNumbersView() {
        lineNumbersView.frame = CGRect(x: 0.0, y: 0.0, width: 40, height: lineNumbersViewHeight)
//        lineNumbersView.font = UIFont.preferredFont(forTextStyle: textStyle)
        lineNumbersView.font = font
        lineNumbersView.textColor = UIColor(Color.lineNumbersGrayColor)
        lineNumbersView.autocapitalizationType = .none
        lineNumbersView.autocorrectionType = .no
        lineNumbersView.isUserInteractionEnabled = true
        lineNumbersView.backgroundColor = UIColor(.replitBackgroundColor)
        lineNumbersView.textAlignment = .right
        lineNumbersView.isSelectable = false
        lineNumbersView.isScrollEnabled = false
        lineNumbersView.text = lineNumbersText
    }
}

extension String {
    func sizeOfString(constrainedToWidth width: Double, font: UIFont) -> CGSize {
        return (self as NSString).boundingRect(with: CGSize(width: width, height: Double.greatestFiniteMagnitude),
                                                 options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                 attributes: [NSAttributedString.Key.font: font],
            context: nil).size
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
