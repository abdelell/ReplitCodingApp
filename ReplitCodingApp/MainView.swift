//
//  ContentView.swift
//  ReplitCodingApp
//
//  Created by user on 11/17/21.
//

import SwiftUI

struct MainView: View {
    
    @State private var codeText = ""
    @State private var lineNumbersText = "1"
//    @State private var codingLines = [Int]()
    
    var body: some View {
        HStack {
//            LineNumbersTextView(text: $lineNumbersText, contentOffset: $scrollingContentOffset)
//                .padding(.vertical)
////                .padding(.trailing, 2)
//                .font(.body)
//                .frame(maxWidth: 35)
//
//            Divider()
            
            CodingTextView(text: $codeText, isSelectable: true)
                .padding(.vertical)
                .onAppear {
                    ApiRequest.uploadCode("x = 'Hello World!'\nprint(x)") { result in
                        switch result {
                        case .success(let output):
                            print("Output: \(output)")
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
//                .onChange(of: codingLines) { newValue in
//                    var currentNumber = 1
//                    var lineNumbers = ""
//
//                    print(newValue)
//                    for numberOfLines in newValue {
//
//                        lineNumbers = "\(lineNumbers)\(currentNumber)\(String(repeating: "\n", count: numberOfLines))"
//                        print(currentNumber)
//                        currentNumber += 1
//                    }
//
//                    lineNumbersText = lineNumbers
//                }
            
            
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
