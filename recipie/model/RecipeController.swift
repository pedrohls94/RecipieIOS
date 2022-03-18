//
//  RecipeController.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import Foundation
import SwiftUI
import CoreData

protocol RecipeController {
    func registerNewRecipe(recipe: Recipe)
    func fetchAllRecipes() -> [Recipe]
}

final class RecipeControllerImpl: RecipeController {
    func registerNewRecipe(recipe: Recipe) {
        recipe.updateAndSave(context: PersistenceController.getContext())
    }
    
    func fetchAllRecipes() -> [Recipe] {
        let context = PersistenceController.getContext()
        let fetchRequest = NSFetchRequest<RecipeMO>(entityName: "RecipeMO")
        let result = try! context.fetch(fetchRequest)
        
        var recipes = [Recipe]()
        for item in result {
            recipes.append(Recipe(item))
        }
        
        return recipes
    }
}
