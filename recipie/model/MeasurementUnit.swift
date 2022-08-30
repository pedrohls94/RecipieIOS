//
//  MeasurementUnit.swift
//  recipie
//
//  Created by Pedro Lenzi on 25/08/22.
//

import Foundation

enum MeasurementUnit: Int, CaseIterable {    
    case units
    case grams
    case mililiters
    
    func toString() -> String {
        switch self {
        case .units:
            return "units"
        case .grams:
            return "grams"
        case .mililiters:
            return "mililiters"
        }
    }
}
