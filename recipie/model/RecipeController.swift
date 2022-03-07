//
//  RecipeController.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import Foundation

protocol RecipeController {
    func registerNewRecipe(recipe: Recipe)
}

final class RecipeControllerImpl: RecipeController {
    func registerNewRecipe(recipe: Recipe) {
        print("did register new recipe with name \(recipe.name)")
    }
}
