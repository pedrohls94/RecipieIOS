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
    
    init(mo: RecipeMO, ingredients: [Ingredient]) {
        managedObject = mo
        name = mo.name!
        self.ingredients = ingredients
    }
    
    init(name: String, ingredients: [Ingredient]) {
        self.name = name
        self.ingredients = ingredients
    }
    
    func updateAndSave(context: NSManagedObjectContext) {
        if managedObject == nil {
            managedObject = RecipeMO(context: context)
        }
        
        managedObject!.name = name
        managedObject!.ingredients = getIngredientsMOs(context: context) as NSSet
        
        do {
            try context.save()
            print("Saved recipe with name \(name)")
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func getIngredientsMOs(context: NSManagedObjectContext) -> Set<IngredientMO> {
        var ingredientsMOs = Set<IngredientMO>()
        for ingredient in ingredients {
            ingredient.updateAndSave(inRecipe: self, context: context)
            ingredientsMOs.insert(ingredient.managedObject!)
        }
        return ingredientsMOs
    }
}
