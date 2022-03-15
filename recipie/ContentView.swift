//
//  ContentView.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import SwiftUI

struct ContentView: View {
    var editRecipeView = EditRecipeView(EditRecipeViewModel(RecipeControllerImpl()))
    
    var body: some View {
        NavigationView {
            
            List {
                HStack {
                    Image("recipe1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipped()
                    Text("Köttbullar")
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                HStack {
                    Image("recipe2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipped()
                    Text("Kyckling")
                }
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: editRecipeView) {
                        Label("Add recipe", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Recipie")
            .navigationBarTitleDisplayMode(.automatic)
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
