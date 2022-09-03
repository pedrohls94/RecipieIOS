//
//  RecipeListViewModel.swift
//  recipie
//
//  Created by Pedro Lenzi on 20/08/22.
//

import SwiftUI
import CoreData

class RecipeListViewModel: ObservableObject, Identifiable {
    @Published var recipeList: [Recipe]
    
    private var recipeController: RecipeController
        
    init(_ recipeController: RecipeController) {
        self.recipeController = recipeController
        
        recipeList = recipeController.fetchAllRecipes()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reload(notification:)), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: nil)
    }
    
    @objc func reload(notification: Notification) {
        recipeList = recipeController.fetchAllRecipes()
    }
}
