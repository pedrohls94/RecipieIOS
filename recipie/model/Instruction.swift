//
//  Instruction.swift
//  recipie
//
//  Created by Pedro Lenzi on 31/08/22.
//

import Foundation
import CoreData

final class Instruction: Identifiable {
    var managedObject: InstructionMO?
    
    var order: Int
    var text: String
    
    init(mo: InstructionMO) {
        managedObject = mo
        
        order = mo.order!.intValue
        text = mo.text!
    }
    
    init(order: Int, text: String) {
        self.order = order
        self.text = text
    }
    
    func updateAndSave(inInstructionSet instructionSet: InstructionSet, context: NSManagedObjectContext) {
        if managedObject == nil {
            managedObject = InstructionMO(context: context)
        }
        
        managedObject!.set = instructionSet.managedObject!
        managedObject!.order = order as NSNumber
        managedObject!.text = text
        
        do {
            try context.save()
            print("Saved instruction")
        } catch {
            print("Error: \(error)")
        }
    }
}
