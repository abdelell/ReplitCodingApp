//
//  ConsoleView.swift
//  ReplitCodingApp
//
//  Created by user on 11/20/21.
//

import Foundation
import SwiftUI

struct ConsoleView: View {
    @Binding var output: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Output")
                    .bold()
                    .font(.body)
                Spacer()
            }
            .padding(5)
            .background(Color.replitDarkBackgroundColor)
            
            ConsoleTextView(text: $output)
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .animation(.linear.speed(1.5))
    }
}
