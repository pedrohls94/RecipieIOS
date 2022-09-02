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
            EditRecipeIngredientsView(viewModel)
            EditRecipeInstructionsView(viewModel)
            VStack {
                Button(action: viewModel.save) {
                    Text("Save")
                }
            }
        }.padding([.leading, .trailing], 50)
    }
}

struct EditRecipeIngredientsView: View {
    @ObservedObject var viewModel: EditRecipeViewModel

    init(_ viewModel: EditRecipeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
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
    }
}

struct EditRecipeInstructionsView: View {
    @ObservedObject var viewModel: EditRecipeViewModel

    init(_ viewModel: EditRecipeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Sets of instructions")
            ForEach(viewModel.instructionSets) { instructionSet in
                Text(instructionSet.name ?? "Instructions")
                ForEach(instructionSet.instructions) { instruction in
                    Text(instruction.text)
                }
                HStack {
                    TextField("Description", text: $viewModel.instructionText)
                    Button(action: viewModel.addInstruction) {
                        Text("add")
                    }
                }
            }
        }
    }
}
