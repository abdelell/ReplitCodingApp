//
//  ProjectItemView.swift
//  ReplitCodingApp
//
//  Created by user on 11/23/21.
//

import SwiftUI

struct ProjectItemView: View {
    @State var title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
    }
}

//struct ProjectItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectItemView()
//    }
//}
