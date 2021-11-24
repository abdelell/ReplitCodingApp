//
//  HomeView.swift
//  ReplitCodingApp
//
//  Created by user on 11/23/21.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isAdding = false
    @State var playgrounds: [Playground] = UserDefaultsManager.getPlaygrounds()
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color.replitDarkBackgroundColor)
        UINavigationBar.appearance().barTintColor = UIColor(Color.replitDarkBackgroundColor)
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(playgrounds, id: \.id) { playground in
                        NavigationLink(destination:
                                        CodingView(codeText: playground.code, playground: playground).onAppear { isAdding = false }
                        ) {
                            ProjectItemView(title: playground.title)
                        }
                        .listRowBackground(Color.replitBackgroundColor)
                    }
                    AddPlaygroundItemView(isAdding: $isAdding, playgrounds: $playgrounds)
                        .listRowBackground(Color.replitBackgroundColor)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .buttonStyle(BorderlessButtonStyle())
            .navigationTitle("Playgrounds")
            .onAppear {
                playgrounds = UserDefaultsManager.getPlaygrounds()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
