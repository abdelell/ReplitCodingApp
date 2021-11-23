//
//  ContentView.swift
//  ReplitCodingApp
//
//  Created by user on 11/17/21.
//

import SwiftUI

struct CodingView: View {
    
    @State private var codeText = ""
    @State private var consoleText = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack {
                    CodingTextView(text: $codeText, isSelectable: true)
                        .padding(.top)
                        .padding(.bottom, 3)
                        .animation(.linear.speed(1.5))
                    
                    PlayButton(codeText: $codeText, consoleText: $consoleText)
                }
                
                ConsoleView(output: $consoleText)
                    .frame(height: geometry.size.height * 0.3)
                    .onTapGesture {
                        hideKeyboard()
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        CodingView()
    }
}
