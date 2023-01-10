//
//  EditRecipeViewModel.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import SwiftUI
import Combine
import PhotosUI

class EditRecipeViewModel: ObservableObject, Identifiable {
    @Published var recipe: Recipe
    
    @Published var recipeImage: Image?
    private var recipeUIImage: UIImage?
    
    @Published var recipeName = "" {
        didSet {
            if recipeName != recipe.name {
                hasChanges = true
            }
        }
    }
    
    @Published var ingredients = [Ingredient]()
    @Published var ingredientName = ""
    @Published var ingredientQuantity = ""
    @Published var ingredientMeasurementUnit: Int = 0 {
        didSet {
            print("did set \(ingredientMeasurementUnit)")
        }
    }
    
    @Published var instructions = [InstructionSet]()
    @Published var instructionText = ""
    
    @Published var shouldDismiss = false
    
    var hasChanges = false
    private var recipeController: RecipeController
    
    init(_ recipeController: RecipeController, recipe: Recipe? = nil) {
        self.recipeController = recipeController
        
        self.recipe = recipe ?? Recipe()
        resetForm()
    }
    
    func resetForm() {
        if let name = recipe.name {
            recipeName = name
        }
        
        recipeImage = Image(uiImage: recipe.image)
        
        ingredients = recipe.ingredients
        instructions = recipe.instructions
        if instructions.count < 1 {
            instructions.append(InstructionSet(identifier: 1))
        }
        
        resetIngredientFields()
        hasChanges = false
    }
    
    func addIngredient() {
        if let quantity = Double(ingredientQuantity) {
            let unit = MeasurementUnit(rawValue: ingredientMeasurementUnit) ?? .units
            let newIngredient = Ingredient(name: ingredientName, measurementUnit: unit, quantity: quantity)
            ingredients.append(newIngredient)
            hasChanges = true
        }
        
        resetIngredientFields()
    }
    
    private func resetIngredientFields() {
        ingredientName = ""
        ingredientQuantity = ""
        ingredientMeasurementUnit = 0
    }
    
    func addInstruction() {
        let currentSet = instructions.last!
        let instruction = Instruction(order: currentSet.instructions.count, text: instructionText)
        currentSet.instructions.append(instruction)
        hasChanges = true
        
        resetInstructionFields()
    }
    
    private func resetInstructionFields() {
        instructionText = ""
    }
    
    func setRecipeImage(_ item: PhotosPickerItem?) async {
        if let data = try? await item?.loadTransferable(type: Data.self) {
            if let uiImage = UIImage(data: data) {
                recipeUIImage = uiImage
                
                DispatchQueue.main.async {
                    self.recipeImage = Image(uiImage: uiImage)
                    self.hasChanges = true
                }
            }
        }
    }
    
    func save() {
        recipe.name = recipeName
        
        if let image = recipeUIImage {
            recipe.image = image
        }
        
        recipe.ingredients = ingredients
        recipe.instructions = instructions
        
        recipeController.saveRecipe(recipe)
        shouldDismiss = true
    }
}
