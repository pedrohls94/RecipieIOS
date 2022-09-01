//
//  InstructionSet.swift
//  recipie
//
//  Created by Pedro Lenzi on 31/08/22.
//

import Foundation
import CoreData

final class InstructionSet: Identifiable {
    var managedObject: InstructionSetMO?
    
    var identifier: Int
    var name: String?
    var instructions: [Instruction]
    
    init(mo: InstructionSetMO, instructions: [Instruction]) {
        managedObject = mo
        
        identifier = mo.identifier!.intValue
        name = mo.name
        self.instructions = instructions
    }
    
    init(identifier: Int, name: String? = nil, instructions: [Instruction]) {
        self.identifier = identifier
        self.name = name
        self.instructions = instructions
    }
    
    func updateAndSave(inRecipe recipe: Recipe, context: NSManagedObjectContext) {
        if managedObject == nil {
            managedObject = InstructionSetMO(context: context)
        }
        
        managedObject!.recipe = recipe.managedObject!
        managedObject!.identifier = identifier as NSNumber
        managedObject!.name = name
        managedObject!.instructions = getInstructionsMOs(context: context)
        
        do {
            try context.save()
            print("Saved instruction set")
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func getInstructionsMOs(context: NSManagedObjectContext) -> NSSet {
        var instructionsMOs = Set<InstructionMO>()
        for instruction in instructions {
            instruction.updateAndSave(inInstructionSet: self, context: context)
            instructionsMOs.insert(instruction.managedObject!)
        }
        return instructionsMOs as NSSet
    }
}
