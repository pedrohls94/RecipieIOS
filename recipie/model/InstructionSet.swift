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
    
    init(identifier: Int, name: String? = nil, instructions: [Instruction] = [Instruction]()) {
        self.identifier = identifier
        self.name = name
        self.instructions = instructions
    }
}
