//
//  RecipeListView.swift
//  recipie
//
//  Created by Pedro Lenzi on 20/08/22.
//

import Foundation

import SwiftUI

struct RecipeListView: View {
    @ObservedObject var viewModel: RecipeListViewModel

    init(_ viewModel: RecipeListViewModel) {
        self.viewModel = viewModel
    }
    
    var editRecipeView = EditRecipeView(EditRecipeViewModel(RecipeControllerImpl()))
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.viewModel.recipeList) { recipe in
                    HStack {
                        buildRecipeRow(recipe)
                    }
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                .listRowBackground(ColorPalette.background)
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: Factory.getEditRecipeView()) {
                        Label("Add recipe", systemImage: "plus")
                    }
                }
            }
            .background(ColorPalette.background)
            .navigationTitle("Recipie")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func buildRecipeRow(_ recipe: Recipe) -> some View {
        NavigationLink(destination: Factory.getEditRecipeView(recipe)) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 15) {
                    recipe.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 80)
                        .clipped()
                    Text(recipe.name ?? "No name recipe")
                        .foregroundColor(ColorPalette.darkText)
                }
            }
        }
    }
}

//struct RecipeListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeListView()
//    }
//}
