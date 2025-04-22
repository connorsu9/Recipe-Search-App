//
//  SearchView.swift
//  AppTeam Final Project
//
//  Created by Connor Su on 4/19/25.
//

import SwiftUI

struct SearchView: View {
    @Binding var text: String
    var body: some View {
        TextField("Search for recipes...", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
    }
}

#Preview {
    //SearchView()
}
