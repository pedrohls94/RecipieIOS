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
    
    init(_ mo: RecipeMO) {
        managedObject = mo
        name = mo.name!
    }
    
    init(name: String) {
        self.name = name
    }
    
    func updateAndSave(context: NSManagedObjectContext) {
        if managedObject == nil {
            managedObject = RecipeMO(context: context)
        }
        
        managedObject!.name = name
        
        do {
            try context.save()
            print("Saved recipe with name \(name)")
        } catch {
            print("Error: \(error)")
        }
    }
}
