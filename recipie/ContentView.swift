//
//  ContentView.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var editRecipeView = EditRecipeView(EditRecipeViewModel(RecipeControllerImpl()))
    
    var body: some View {
        NavigationView {
            List {
                Text("hello")
                Text("2")
            }
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: editRecipeView) {
                        Label("Add recipe", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func addRecipe() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
