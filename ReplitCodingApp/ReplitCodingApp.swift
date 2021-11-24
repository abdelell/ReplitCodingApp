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
            HomeView()
                .background(Color.replitBackgroundColor.ignoresSafeArea())
        }
    }
}
