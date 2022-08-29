//
//  EditRecipeViewModel.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import SwiftUI
import Combine

class EditRecipeViewModel: ObservableObject, Identifiable {
    @Published var name = ""
    
    private var recipeController: RecipeController
    
    init(_ recipeController: RecipeController) {
        self.recipeController = recipeController
    }
    
    func save(name: String) {
        
    }
}
