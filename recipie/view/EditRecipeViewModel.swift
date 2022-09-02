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
    @Published var instructionSets = [InstructionSet]()
    
    @Published var ingredientName = ""
    @Published var ingredientQuantity = ""
    @Published var ingredientMeasurementUnit: MeasurementUnit = .units
    
    @Published var instructionText = ""
    
    private var recipeController: RecipeController
    
    init(_ recipeController: RecipeController) {
        self.recipeController = recipeController
        
        instructionSets.append(InstructionSet(identifier: 1, name: "Set 1"))
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
    
    func addInstruction() {
        let currentSet = instructionSets.last!
        let instruction = Instruction(order: currentSet.instructions.count, text: instructionText)
        currentSet.instructions.append(instruction)
        
        instructionText = ""
    }
    
    func save() {
        let recipe = Recipe(name: recipeName, ingredients: ingredients, instructions: instructionSets)
        recipeController.registerNewRecipe(recipe: recipe)
    }
}
