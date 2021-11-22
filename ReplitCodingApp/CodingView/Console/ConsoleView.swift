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
    @Binding var isCollapsed: Bool {
        didSet {
            if !isCollapsed {
                hideKeyboard()
            }
        }
    }
    
    var body: some View {
        ConsoleTextView(text: $output)
//            .padding()
//            .padding(.top, 30)
            .overlay(
                VStack(spacing: 0) {
                    HStack {
                        HStack(spacing: 0) {
                            Image(systemName: isCollapsed ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                                .font(.system(size: 14))
                            Text(" Output")
                                .bold()
                                .font(.callout)
                        }
                        .padding([.horizontal])
//                        .padding(.vertical, 5)
                        .background(Color.replitDarkBackgroundColor)
                        .cornerRadius(10, corners: [.topRight])
                        .onTapGesture {
                            isCollapsed.toggle()
                        }
                        Spacer()
                    }
//                    .background(Color.clear)
                    
                    // Top Border
                    Rectangle()
                        .frame(width: nil, height: 7, alignment: .top)
                        .foregroundColor(Color.replitDarkBackgroundColor)
                        
                }, alignment: .top
            )
//            .frame(maxHeight: isCollapsed ? 0 : .none)
            .animation(.easeOut)
            .transition(.slide)
    }
}
