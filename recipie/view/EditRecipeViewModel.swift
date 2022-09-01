//
//  EditRecipeViewModel.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import SwiftUI
import Combine

class EditRecipeViewModel: ObservableObject, Identifiable {
    @Published var recipeName = ""
    @Published var ingredients = [Ingredient]()
    
    @Published var ingredientName = ""
    @Published var ingredientQuantity = ""
    @Published var ingredientMeasurementUnit: MeasurementUnit = .units
    
    private var recipeController: RecipeController
    
    init(_ recipeController: RecipeController) {
        self.recipeController = recipeController
    }
    
    func addIngredient() {
        if let quantity = Double(ingredientQuantity) {
            let newIngredient = Ingredient(name: ingredientName, measurementUnit: ingredientMeasurementUnit, quantity: quantity)
            ingredients.append(newIngredient)
        }
        
        resetIngredientFields()
    }
    
    func resetIngredientFields() {
        ingredientName = ""
        ingredientQuantity = ""
        ingredientMeasurementUnit = .units
    }
    
    func save() {
        let recipe = Recipe(name: recipeName, ingredients: ingredients, instructions: [InstructionSet]())
        recipeController.registerNewRecipe(recipe: recipe)
    }
}
