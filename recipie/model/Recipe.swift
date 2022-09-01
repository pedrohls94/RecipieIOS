//
//  Recipe.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import Foundation
import CoreData

final class Recipe: Identifiable {
    var managedObject: RecipeMO?
    var name: String
    var ingredients: [Ingredient]
    var instructions: [InstructionSet]
    
    init(mo: RecipeMO, ingredients: [Ingredient], instructions: [InstructionSet]) {
        managedObject = mo
        name = mo.name!
        self.ingredients = ingredients
        self.instructions = instructions
    }
    
    init(name: String, ingredients: [Ingredient], instructions: [InstructionSet]) {
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
    }
    
    func updateAndSave(context: NSManagedObjectContext) {
        if managedObject == nil {
            managedObject = RecipeMO(context: context)
        }
        
        managedObject!.name = name
        managedObject!.ingredients = getIngredientsMOs(context: context)
        managedObject!.instructions = getInstructionSetsMOs(context: context)
        
        do {
            try context.save()
            print("Saved recipe with name \(name)")
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func getIngredientsMOs(context: NSManagedObjectContext) -> NSSet {
        var ingredientsMOs = Set<IngredientMO>()
        for ingredient in ingredients {
            ingredient.updateAndSave(inRecipe: self, context: context)
            ingredientsMOs.insert(ingredient.managedObject!)
        }
        return ingredientsMOs as NSSet
    }
    
    private func getInstructionSetsMOs(context: NSManagedObjectContext) -> NSSet {
        var instructionSetsMOs = Set<InstructionSetMO>()
        for instruction in instructions {
            instruction.updateAndSave(inRecipe: self, context: context)
            instructionSetsMOs.insert(instruction.managedObject!)
        }
        return instructionSetsMOs as NSSet
    }
}
