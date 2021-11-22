//
//  ConsoleTextView.swift
//  ReplitCodingApp
//
//  Created by user on 11/20/21.
//

import Foundation
import SwiftUI

struct ConsoleTextView: UIViewRepresentable {
    
    @Binding var text: String
    
    let font = UIFont(name: "Courier", size: 16)
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.font = font
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.backgroundColor = UIColor(.replitBackgroundColor)
        textView.tintColor = .white
//        textView.contentOffset = CGPoint(x: 100.0, y: 0.0)
        textView.textContainerInset = UIEdgeInsets(top: 34, left: 10, bottom: 0, right: 0)
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
