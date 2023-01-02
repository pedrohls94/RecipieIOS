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
    func saveRecipe(_ recipe: Recipe)
    func fetchAllRecipes() -> [Recipe]
}

final class RecipeControllerImpl: RecipeController {
    func saveRecipe(_ recipe: Recipe) {
        let context = PersistenceController.getContext()
        if recipe.managedObject == nil {
            recipe.managedObject = RecipeMO(context: context)
        }
        
        recipe.managedObject!.name = recipe.name
        recipe.managedObject!.ingredients = getIngredientsMOs(recipe: recipe, context: context)
        recipe.managedObject!.instructions = getInstructionSetsMOs(recipe: recipe, context: context)
        recipe.managedObject!.imageLocalPath = FileController.saveImageData(Data(), forRecipe: recipe.managedObject!) //FIXME
        
        do {
            try context.save()
            print("Saved recipe with name \(recipe.name ?? "-")")
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func getIngredientsMOs(recipe: Recipe, context: NSManagedObjectContext) -> NSSet {
        var ingredientsMOs = Set<IngredientMO>()
        for ingredient in recipe.ingredients {
            saveIngredient(ingredient, inRecipe: recipe, context: context)
            ingredientsMOs.insert(ingredient.managedObject!)
        }
        return ingredientsMOs as NSSet
    }
    
    func saveIngredient(_ ingredient: Ingredient, inRecipe recipe: Recipe, context: NSManagedObjectContext) {
        if ingredient.managedObject == nil {
            ingredient.managedObject = IngredientMO(context: context)
        }
        
        ingredient.managedObject!.name = ingredient.name
        ingredient.managedObject!.recipe = recipe.managedObject!
        ingredient.managedObject!.measurementUnit = Int32(ingredient.measurementUnit.rawValue)
        ingredient.managedObject!.quantity = ingredient.quantity
        
        do {
            try context.save()
            print("Saved ingredient with name \(ingredient.name)")
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func getInstructionSetsMOs(recipe: Recipe, context: NSManagedObjectContext) -> NSSet {
        var instructionSetsMOs = Set<InstructionSetMO>()
        for instruction in recipe.instructions {
            saveInstructionSet(instruction, inRecipe: recipe, context: context)
            instructionSetsMOs.insert(instruction.managedObject!)
        }
        return instructionSetsMOs as NSSet
    }
    
    func saveInstructionSet(_ instructionSet: InstructionSet, inRecipe recipe: Recipe, context: NSManagedObjectContext) {
        if instructionSet.managedObject == nil {
            instructionSet.managedObject = InstructionSetMO(context: context)
        }
        
        instructionSet.managedObject!.recipe = recipe.managedObject!
        instructionSet.managedObject!.identifier = instructionSet.identifier as NSNumber
        instructionSet.managedObject!.name = instructionSet.name
        instructionSet.managedObject!.instructions = getInstructionsMOs(instructionSet, context: context)
        
        do {
            try context.save()
            print("Saved instruction set")
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func getInstructionsMOs(_ instructionSet: InstructionSet,context: NSManagedObjectContext) -> NSSet {
        var instructionsMOs = Set<InstructionMO>()
        for instruction in instructionSet.instructions {
            saveInstruction(instruction, inInstructionSet: instructionSet, context: context)
            instructionsMOs.insert(instruction.managedObject!)
        }
        return instructionsMOs as NSSet
    }
    
    func saveInstruction(_ instruction: Instruction, inInstructionSet instructionSet: InstructionSet, context: NSManagedObjectContext) {
        if instruction.managedObject == nil {
            instruction.managedObject = InstructionMO(context: context)
        }
        
        instruction.managedObject!.set = instructionSet.managedObject!
        instruction.managedObject!.order = instruction.order as NSNumber
        instruction.managedObject!.text = instruction.text
        
        do {
            try context.save()
            print("Saved instruction")
        } catch {
            print("Error: \(error)")
        }
    }
    
    func fetchAllRecipes() -> [Recipe] {
        let context = PersistenceController.getContext()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let fetchRequest = NSFetchRequest<RecipeMO>(entityName: "RecipeMO")
        fetchRequest.sortDescriptors = [sortDescriptor]
        
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
