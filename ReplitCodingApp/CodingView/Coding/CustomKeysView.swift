//
//  CustomKeysView.swift
//  ReplitCodingApp
//
//  Created by user on 11/20/21.
//

import Foundation
import SwiftUI

struct CustomKeysView: View {
    @State var textView: UITextView
    
    var body: some View {
        HStack(spacing: 7) {
            KeyButton(text: "tab", enteredText: "  ", textView: textView)
            KeyButton(text: "+", enteredText: "+", textView: textView)
            KeyButton(text: "=", enteredText: "=", textView: textView)
            KeyButton(text: "\"", enteredText: "\"", textView: textView)
            KeyButton(text: "(", enteredText: "(", textView: textView)
            KeyButton(text: ")", enteredText: ")", textView: textView)
        }
        .padding(.top, 5)
    }
}

struct KeyButton: View {
    var text: String
    var enteredText: String
    @State var textView: UITextView
    
    var body: some View {
        Button {
            textView.insertText(enteredText)
        } label: {
            Text(text)
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: 50, maxHeight: 40)
                .background(Color.keyBackground)
                .cornerRadius(5)
        }
        .contentShape(Rectangle())
    }
}
