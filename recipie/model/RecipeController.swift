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
            let ingredients = getIngredientsFrom(recipeMO: item)
            let instructionSets = getInstructionSetsFrom(recipeMO: item)
            recipes.append(Recipe(mo: item, ingredients: ingredients, instructions: instructionSets))
        }
        
        return recipes
    }
    
    private func getIngredientsFrom(recipeMO: RecipeMO) -> [Ingredient] {
        var ingredients = [Ingredient]()
        for ingredient in Array(recipeMO.ingredients ?? NSSet()) {
            ingredients.append(Ingredient(mo: ingredient as! IngredientMO))
        }
        return ingredients
    }
    
    private func getInstructionSetsFrom(recipeMO: RecipeMO) -> [InstructionSet] {
        var instructionSets = [InstructionSet]()
        for item in Array(recipeMO.instructions ?? NSSet()) {
            let instructionSetMO = item as! InstructionSetMO
            let instructions = getInstructionsFrom(instructionSetMO: instructionSetMO)
            instructionSets.append(InstructionSet(mo: instructionSetMO, instructions: instructions))
        }
        return instructionSets
    }
    
    private func getInstructionsFrom(instructionSetMO: InstructionSetMO) -> [Instruction] {
        var instructions = [Instruction]()
        for instruction in Array(instructionSetMO.instructions ?? NSSet()) {
            instructions.append(Instruction(mo: instruction as! InstructionMO))
        }
        return instructions
    }
}
