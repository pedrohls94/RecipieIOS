//
//  EditRecipeViewModel.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import SwiftUI
import Combine

class EditRecipeViewModel: ObservableObject, Identifiable {
    @Published var name: String = ""
    
    private var recipeController: RecipeController
    
    private var disposables = Set<AnyCancellable>()
    
    init(_ recipeController: RecipeController) {
        self.recipeController = recipeController
        let scheduler = DispatchQueue.global()
        
        $name.debounce(for: .seconds(0.5), scheduler: scheduler).dropFirst(1).sink(receiveValue: save(name:)).store(in: &disposables)
    }
    
    func save(name: String) {
        let recipe = Recipe(name: name)
        recipeController.registerNewRecipe(recipe: recipe)
        
        let recipes = recipeController.fetchAllRecipes()
        print("\(recipes.count) recipes in the db")
        for item in recipes {
            print("recipe name: \(item.name)")
        }
        
    }
}
