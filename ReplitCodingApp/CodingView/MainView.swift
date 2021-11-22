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
    @State private var consoleText = ""
    @State private var collapseConsole = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack {
                    CodingTextView(text: $codeText, isSelectable: true)
                        .padding(.vertical)
//                        .onTapGesture {
//                            collapseConsole = true
//                        }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
//                                collapseConsole = false
                                hideKeyboard()
                                
                                ApiRequest.uploadCode(codeText) { result in
                                    switch result {
                                    case .success(let output):
                                        consoleText = output
                                        print("Output: \(output)")
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                    }
                                }
                                
                            } label: {
                                Image(systemName: "play.fill")
                                    .foregroundColor(.white)
                                    .frame(width: 70, height: 70)
                                    .background(Color.playButtonBrightGreen)
                                    .clipShape(Circle())
                                    .padding(.horizontal)
                            }
                            .animation(.easeOut)
                            .transition(.slide)
                        }
                    }
                }
                
                if !collapseConsole {
                    ConsoleView(output: $consoleText, isCollapsed: $collapseConsole)
                        .frame(height: geometry.size.height * 0.3)
                        .ignoresSafeArea(.keyboard)
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
