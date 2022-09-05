//
//  EditRecipeViewModel.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import SwiftUI
import Combine

class EditRecipeViewModel: ObservableObject, Identifiable {
    @Published var recipe: Recipe
    
    @Published var recipeName = ""
//    @Published var ingredients = [Ingredient]()
//    @Published var instructionSets = [InstructionSet]()
    
    @Published var ingredientName = ""
    @Published var ingredientQuantity = ""
    @Published var ingredientMeasurementUnit: MeasurementUnit = .units
    
    @Published var instructionText = ""
    
    @Published var shouldDismiss = false
    
    private var recipeController: RecipeController
    
    init(_ recipeController: RecipeController, recipe: Recipe? = nil) {
        self.recipeController = recipeController
        
        self.recipe = recipe ?? Recipe()
        self.recipe.instructions.append(InstructionSet(identifier: 1, name: "Set 1"))
    }
    
    func addIngredient() {
        if let quantity = Double(ingredientQuantity) {
            let newIngredient = Ingredient(name: ingredientName, measurementUnit: ingredientMeasurementUnit, quantity: quantity)
            recipe.ingredients.append(newIngredient)
        }
        
        resetIngredientFields()
    }
    
    func resetIngredientFields() {
        ingredientName = ""
        ingredientQuantity = ""
        ingredientMeasurementUnit = .units
    }
    
    func addInstruction() {
        let currentSet = recipe.instructions.last!
        let instruction = Instruction(order: currentSet.instructions.count, text: instructionText)
        currentSet.instructions.append(instruction)
        
        instructionText = ""
    }
    
    func save() {
        recipe.name = recipeName
        recipeController.saveRecipe(recipe)
        shouldDismiss = true
    }
}
