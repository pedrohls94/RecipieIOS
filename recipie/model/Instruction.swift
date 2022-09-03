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
}
