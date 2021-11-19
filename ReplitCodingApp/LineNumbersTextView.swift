//
//  LineNumbersTextView.swift
//  ReplitCodingApp
//
//  Created by user on 11/18/21.
//

import Foundation
import SwiftUI

struct LineNumbersTextView: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var contentOffset: CGPoint
    var textStyle: UIFont.TextStyle = .body
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.delegate = context.coordinator
        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor(.replitBackgroundColor)
        textView.textAlignment = .right
        textView.isSelectable = false
        textView.isScrollEnabled = true
        textView.contentOffset = contentOffset
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
        print("ContentOFFSET: \(contentOffset)")
        uiView.contentOffset = contentOffset
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($contentOffset)
    }
     
    class Coordinator: NSObject, UITextViewDelegate {
        var contentOffset: Binding<CGPoint> {
            didSet {
                print("YO: \(contentOffset)")
            }
        }
     
        init(_ contentOffset: Binding<CGPoint>) {
            self.contentOffset = contentOffset
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            print("LineNumbers will change: \(self.contentOffset.wrappedValue)")
            scrollView.contentOffset = self.contentOffset.wrappedValue
        }
        
    }

}
