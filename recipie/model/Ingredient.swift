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
}
