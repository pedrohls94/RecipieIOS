//
//  Recipe.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import Foundation
import CoreData
import SwiftUI

final class Recipe: Identifiable  {
    var managedObject: RecipeMO?
    var name: String?
    var ingredients = [Ingredient]()
    var instructions = [InstructionSet]()
    var image: UIImage?
    
    init(mo: RecipeMO, ingredients: [Ingredient], instructions: [InstructionSet]) {
        managedObject = mo
        name = mo.name!
        self.ingredients = ingredients
        self.instructions = instructions
        
        if let mo = self.managedObject,
           let data = FileController.getImageData(from: mo),
           let uiImage = UIImage(data: data) {
            image = uiImage
        }
    }
    
    init() {
        
    }
}
