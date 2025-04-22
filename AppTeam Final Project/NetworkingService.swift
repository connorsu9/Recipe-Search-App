//
//  NetworkingService.swift
//  AppTeam Final Project
//
//  Created by Connor Su on 4/8/25.
//

import Foundation

class NetworkingService {
    
    
    static func searchRecipes(query: String) async throws -> [Recipe] {
        let apiKey = "01a9fdadea1f441bb02771fa8da67a5d"
        
        var components = URLComponents(string: "https://api.spoonacular.com/recipes/complexSearch")!
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "query", value: query)
            ]
        
        guard let url = components.url else {
            fatalError("Invalid URL components: \(components)")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedResponse = try JSONDecoder().decode(RecipeSearchResponse.self, from: data)
            return decodedResponse.results
        } catch {
            print("Error: \(error)")
            throw error
        }
        
    }
    
    static func getRecipeDetail(id: Int) async throws -> RecipeDetailResponse {
        let apiKey = "01a9fdadea1f441bb02771fa8da67a5d"
        
        var components = URLComponents(string: "https://api.spoonacular.com/recipes/\(id)/information")!
                components.queryItems = [
                    URLQueryItem(name: "apiKey",            value: apiKey),
                    URLQueryItem(name: "includeNutrition", value: "false")
                ]
        guard let url = components.url else {
            fatalError("Invalid URL components: \(components)")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(RecipeDetailResponse.self, from: data)
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
    
    
    
    
}
