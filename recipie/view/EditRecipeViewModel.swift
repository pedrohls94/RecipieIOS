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
    
    @Published var recipeName = ""
    
    @Published var ingredientName = ""
    @Published var ingredientQuantity = ""
    @Published var ingredientMeasurementUnit: Int = 0 {
        didSet {
            print("did set \(ingredientMeasurementUnit)")
        }
    }
    
    @Published var instructionText = ""
    
    @Published var shouldDismiss = false
    
    private var recipeController: RecipeController
    
    init(_ recipeController: RecipeController, recipe: Recipe? = nil) {
        self.recipeController = recipeController
        
        self.recipe = recipe ?? Recipe()
        if let name = recipe?.name {
            recipeName = name
        }
        
        setRecipeImage()
        
        if self.recipe.instructions.count < 1 {
            self.recipe.instructions.append(InstructionSet(identifier: 1))
        }
    }
    
    func addIngredient() {
        if let quantity = Double(ingredientQuantity) {
            let unit = MeasurementUnit(rawValue: ingredientMeasurementUnit) ?? .units
            let newIngredient = Ingredient(name: ingredientName, measurementUnit: unit, quantity: quantity)
            recipe.ingredients.append(newIngredient)
        }
        
        resetIngredientFields()
    }
    
    func resetIngredientFields() {
        ingredientName = ""
        ingredientQuantity = ""
        ingredientMeasurementUnit = 0
    }
    
    func addInstruction() {
        let currentSet = recipe.instructions.last!
        let instruction = Instruction(order: currentSet.instructions.count, text: instructionText)
        currentSet.instructions.append(instruction)
        
        instructionText = ""
    }
    
    func setRecipeImage(_ item: PhotosPickerItem?) async {
        if let data = try? await item?.loadTransferable(type: Data.self) {
            if let uiImage = UIImage(data: data) {
                recipe.image = uiImage
                DispatchQueue.main.async {
                    self.setRecipeImage()
                }
            }
        }
    }
    
    private func setRecipeImage() {
        recipeImage = ImageHelper.getImageForRecipe(self.recipe)
    }
    
    func save() {
        recipe.name = recipeName
        recipeController.saveRecipe(recipe)
        shouldDismiss = true
    }
}
