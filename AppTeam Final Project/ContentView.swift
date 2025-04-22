//
//  ContentView.swift
//  AppTeam Final Project
//
//  Created by Connor Su on 4/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    @State private var recipes: [Recipe] = []
    @State private var errorMessage: String?
    
    init() {
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.blue]

        }
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
        ]

    
    var body: some View {
        NavigationStack {
            ScrollView {
                if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }
                
                SearchView(text: $searchText)
                    .onSubmit {
                        Task {
                            await searchForRecipes()
                        }
                    }
                
                LazyVGrid(columns: columns) {
                    ForEach(recipes, id: \.self) { recipe in
                        VStack(alignment: .leading) {
                            NavigationLink {
                                RecipeView(recipe: recipe)
                                
                            } label: {
                                VStack {
                                    Image(recipe.image ?? "No Image")
                                    Text(recipe.title)
                                        .frame(maxWidth: .infinity)
                                        .font(.title3)
                                        .ignoresSafeArea()
                                    AsyncImage(url: URL(string: recipe.image ?? "")) { image in
                                        image.resizable().scaledToFit()
                                    } placeholder: {
                                        Color.gray.frame(height: 175)
                                    }
                                    
                                }
                                .clipShape(.rect(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray))
                            }
                        }
                    }
                }
            }
            .navigationTitle("Recipe Search")
        }

    }
        
    
    
    func searchForRecipes() async {
        do {
            let results = try await NetworkingService.searchRecipes(query: searchText)
            await MainActor.run {
                self.recipes = results
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}


#Preview {

    ContentView()
}
