//
//  EditRecipeView.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import SwiftUI

struct EditRecipeView: View {
    @ObservedObject var viewModel: EditRecipeViewModel

    init(_ viewModel: EditRecipeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Recipe name", text: $viewModel.recipeName)
            }
            VStack {
                Text("Ingredients")
                VStack {
                    ForEach(viewModel.ingredients) { ingredient in
                        HStack {
                            Text(String(format: "%g", ingredient.quantity))
                            Text("\(ingredient.measurementUnit.toString())")
                            Text(ingredient.name)
                        }
                    }
                    HStack {
                        TextField("Name", text: $viewModel.ingredientName)
                        TextField("Quantity", text: $viewModel.ingredientQuantity)
                        Picker("Measurement Unit", selection: $viewModel.ingredientMeasurementUnit) {
                            ForEach(MeasurementUnit.allCases, id: \.rawValue) { unit in
                                Text(unit.toString())
                            }
                        }
                        Button(action: viewModel.addIngredient) {
                            Text("add")
                        }
                    }
                }
            }
            VStack {
                Button(action: viewModel.save) {
                    Text("Save")
                }
            }
        }.padding([.leading, .trailing], 50)
    }
}
