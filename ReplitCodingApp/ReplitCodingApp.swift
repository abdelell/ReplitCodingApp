//
//  ReplitCodingAppApp.swift
//  ReplitCodingApp
//
//  Created by user on 11/17/21.
//

import SwiftUI

@main
struct ReplitCodingApp: App {
    var body: some Scene {
        WindowGroup {
            CodingView()
                .background(Color.replitBackgroundColor.ignoresSafeArea())
        }
    }
}
