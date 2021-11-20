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
    
    var body: some View {
        ZStack {
            CodingTextView(text: $codeText, isSelectable: true)
                .padding(.vertical)
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
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension Character
{
    func unicodeScalarCodePoint() -> UInt32
    {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars

        return scalars[scalars.startIndex].value
    }
}
