//
//  RecipeIngredient.swift
//  recipie
//
//  Created by Pedro Lenzi on 25/08/22.
//

import Foundation
import CoreData

final class Ingredient: Identifiable {    
    var managedObject: IngredientMO?
    
    var name: String
    var measurementUnit: MeasurementUnit
    var quantity: Double
    
    init(mo: IngredientMO) {
        managedObject = mo
        
        name = mo.name!
        measurementUnit = MeasurementUnit(rawValue: Int(mo.measurementUnit))!
        quantity = mo.quantity
    }
    
    init(name: String, measurementUnit: MeasurementUnit, quantity: Double) {
        self.name = name
        self.measurementUnit = measurementUnit
        self.quantity = quantity
    }
    
    func updateAndSave(inRecipe recipe: Recipe, context: NSManagedObjectContext) {
        if managedObject == nil {
            managedObject = IngredientMO(context: context)
        }
        
        managedObject!.name = name
        managedObject!.recipe = recipe.managedObject!
        managedObject!.measurementUnit = Int32(measurementUnit.rawValue)
        managedObject!.quantity = quantity
        
        do {
            try context.save()
            print("Saved ingredient with name \(name)")
        } catch {
            print("Error: \(error)")
        }
    }
}
