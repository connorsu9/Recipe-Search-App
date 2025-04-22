//
//  RecipeView.swift
//  AppTeam Final Project
//
//  Created by Connor Su on 4/14/25.
//

import SwiftUI

import SwiftUI

struct RecipeView: View {
    let recipe: Recipe
    @State private var foods: [Food] = []
    @State private var instructions: String?
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: recipe.image ?? "")) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    Color.gray.frame(height: 200)
                }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                Text("Ingredients")
                    .font(.headline)
                if foods.isEmpty {
                    Text("No ingredients found.")
                        .italic()
                } else {
                    ForEach(foods) { food in
                        Text("\(food.original ?? food.name)")
                    }
                }
                
                Divider()
                
                if let instructions = instructions {
                    Text("Instructions")
                        .font(.headline)
                    Text(instructions)
                        .padding()
                }
                
            }
        }
        .navigationTitle(recipe.title)
        .task { await loadDetail() }
    }
    
    func loadDetail() async {
        do {
            let detail = try await NetworkingService.getRecipeDetail(id: recipe.id)
            await MainActor.run {
                self.foods = detail.extendedIngredients
                self.instructions = detail.instructions
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

