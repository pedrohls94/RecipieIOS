//
//  Recipe.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import Foundation
import CoreData

final class Recipe: Identifiable  {
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
}
