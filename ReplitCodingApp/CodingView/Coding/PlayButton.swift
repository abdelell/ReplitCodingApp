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
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Button {
                    hideKeyboard()
                    
                    ApiRequest.uploadCode(codeText) { result in
                        switch result {
                        case .success(let output):
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
            }
        }
    }
    
}
