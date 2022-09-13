//
//  Factory.swift
//  recipie
//
//  Created by Pedro Lenzi on 12/09/22.
//

import Foundation

class Factory {
    static func getEditRecipeView(_ recipe: Recipe? = nil) -> EditRecipeView {
        return EditRecipeView(EditRecipeViewModel(RecipeControllerImpl(), recipe: recipe))
    }
}
