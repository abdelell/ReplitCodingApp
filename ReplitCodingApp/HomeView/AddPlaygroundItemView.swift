//
//  AddPlaygroundItem.swift
//  ReplitCodingApp
//
//  Created by user on 11/23/21.
//

import SwiftUI

struct AddPlaygroundItemView: View {
    @Binding var isAdding: Bool
    @Binding var playgrounds: [Playground]
    
    @State private var text: String = ""
    @State private var isFirstResponder = true
    var body: some View {
        if isAdding {
            HStack {
                CustomTextField(text: $text, isFirstResponder: $isFirstResponder)
                    .onAppear {
                        isFirstResponder = true
                    }
                
                let title = text.trimmingCharacters(in: .whitespaces)
                Button {
                    isAdding = false
                    
                    if title != "" {
                        let id = UUID()
                        let playground = Playground(id: "\(id)", title: title, code: "print('hello')")
                        playgrounds.append(playground)
                        
                        UserDefaultsManager.addPlayground(playground: playground)
                    }
                    
                    text = ""
                    hideKeyboard()
                    
                    isFirstResponder = false
                } label: {
                    Text(title != "" ? "Add" : "Cancel")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(title != "" ? Color.playButtonBrightGreen : Color.redCancelColor)
                        .cornerRadius(5)
                }
                
            }
        } else {
            Button {
                isAdding = true
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.headline)
                    Spacer()
                }
            }
            .contentShape(Rectangle())
        }
    }
}
