//
//  ContentView.swift
//  ReplitCodingApp
//
//  Created by user on 11/17/21.
//

import SwiftUI

struct CodingView: View {
    
    @State var codeText = ""
    @State private var consoleText = ""
    @State var playground: Playground
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack {
                    CodingTextView(text: $codeText, isSelectable: true)
                        .padding(.top)
                        .padding(.bottom, 3)
                        .animation(.linear.speed(1.5))
                        .background(Color.replitBackgroundColor)
                    
                    PlayButton(codeText: $codeText, consoleText: $consoleText, playground: $playground)
                }
                
                ConsoleView(output: $consoleText)
                    .frame(height: geometry.size.height * 0.3)
                    .onTapGesture {
                        hideKeyboard()
                    }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(playground.title)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
            
            // Save code
            UserDefaultsManager.updatePlaygroundCode(playground: playground, newCode: codeText)
        }){
            Image(systemName: "arrow.left")
                .foregroundColor(.white)
        }.contentShape(Rectangle()))
    }
}
