//
//  RecipeListViewModel.swift
//  recipie
//
//  Created by Pedro Lenzi on 20/08/22.
//

import SwiftUI
import Combine

class RecipeListViewModel: ObservableObject, Identifiable {
    @Published var recipeList: [Recipe]
    
    private var recipeController: RecipeController
    
    private var disposables = Set<AnyCancellable>()
    
    init(_ recipeController: RecipeController) {
        self.recipeController = recipeController
        
        recipeList = recipeController.fetchAllRecipes()
    }
}
