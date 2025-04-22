//
//  Food.swift
//  AppTeam Final Project
//
//  Created by Connor Su on 4/15/25.
//

import Foundation

struct Food: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let image: String?
    let amount: Double?        
    let unit: String?
    let original: String?
    let meta: [String]?
    
}

struct RecipeDetailResponse: Codable {
    let extendedIngredients: [Food]
    let instructions: String?
}
