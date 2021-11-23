//
//  PlayButton.swift
//  ReplitCodingApp
//
//  Created by user on 11/20/21.
//

import Foundation
import SwiftUI

struct PlayButton: View {
    @Binding var codeText: String
    @Binding var consoleText: String
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Button {
                    hideKeyboard()
                    
                    ApiRequest.uploadCode(codeText.makeItCodeCompatible()) { result in
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
                        .padding()
                }
                .animation(.easeOut.speed(1.2))
            }
        }
    }
    
}
