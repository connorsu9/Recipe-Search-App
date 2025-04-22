//
//  Recipe.swift
//  AppTeam Final Project
//
//  Created by Connor Su on 4/8/25.
//

import Foundation

struct Recipe: Codable, Hashable {    
    let id: Int
    let title: String
    let image: String?
    

}

struct RecipeSearchResponse: Codable {
    let results: [Recipe]
    let offset: Int
    let number: Int
    let totalResults: Int
}
