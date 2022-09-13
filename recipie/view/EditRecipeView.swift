//
//  EditRecipeView.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import SwiftUI

struct EditRecipeView: View {
    @ObservedObject var viewModel: EditRecipeViewModel
    
    @Environment(\.presentationMode) var presentationMode

    init(_ viewModel: EditRecipeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            EditRecipeImageView(viewModel)
            EditRecipeDetailsView(viewModel)
            EditRecipeIngredientsView(viewModel)
            EditRecipeInstructionsView(viewModel)
            VStack {
                Button(action: viewModel.save) {
                    Text("Save").foregroundColor(ColorPalette.highlight)
                }
            }.padding()
        }
        .background(ColorPalette.background)
        .navigationTitle("Edit Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .padding([.leading, .trailing], 50)
        .onReceive(viewModel.$shouldDismiss) { shouldDismiss in
            if shouldDismiss {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct EditRecipeImageView: View {
    @ObservedObject var viewModel: EditRecipeViewModel

    init(_ viewModel: EditRecipeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle().fill(ColorPalette.highlight).frame(width: UIScreen.main.bounds.size.width, height: 2, alignment: .center)
            viewModel.recipe.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .center)
                .clipped()
            Rectangle().fill(ColorPalette.highlight).frame(width: UIScreen.main.bounds.size.width, height: 2, alignment: .center)
        }
    }
}

struct EditRecipeDetailsView: View {
    @ObservedObject var viewModel: EditRecipeViewModel

    init(_ viewModel: EditRecipeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recipe Name")
                .foregroundColor(ColorPalette.darkText)
                .font(.callout.weight(.bold))
            TextField("Give a name to your recipe", text: $viewModel.recipeName)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(ColorPalette.highlight, lineWidth: 1)
                )
        }
        .padding()
    }
}

struct EditRecipeIngredientsView: View {
    @ObservedObject var viewModel: EditRecipeViewModel

    init(_ viewModel: EditRecipeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .foregroundColor(ColorPalette.darkText)
                .padding(.bottom, 5)
                .font(.callout.weight(.bold))
            ForEach(viewModel.recipe.ingredients) { ingredient in
                HStack {
                    Text("- \(String(format: "%g", ingredient.quantity)) \(ingredient.measurementUnit.toString())").foregroundColor(ColorPalette.darkText)
                    Text(ingredient.name).foregroundColor(ColorPalette.darkText)
                }
            }
            HStack {
                TextField("Name", text: $viewModel.ingredientName)
                Rectangle().fill(ColorPalette.highlight).frame(width: 1, height: 15, alignment: .center)
                TextField("Quantity", text: $viewModel.ingredientQuantity)
                Rectangle().fill(ColorPalette.highlight).frame(width: 1, height: 15, alignment: .center)
                Menu{
                    Picker("Measurement Unit", selection: $viewModel.ingredientMeasurementUnit) {
                        ForEach(MeasurementUnit.allCases, id: \.rawValue) { unit in
                            Text(unit.toString())
                        }
                    }.labelsHidden().pickerStyle(InlinePickerStyle())
                } label: {
                    Text(MeasurementUnit(rawValue: viewModel.ingredientMeasurementUnit)!.toString()).foregroundColor(ColorPalette.highlight)
                }
                Rectangle().fill(ColorPalette.highlight).frame(width: 1, height: 15, alignment: .center)
                Button(action: viewModel.addIngredient) {
                    Text("add")
                        .foregroundColor(ColorPalette.highlight)
                }
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(ColorPalette.highlight, lineWidth: 1)
            )
        }
        .padding()
    }
}

struct EditRecipeInstructionsView: View {
    @ObservedObject var viewModel: EditRecipeViewModel

    init(_ viewModel: EditRecipeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .foregroundColor(ColorPalette.darkText)
                .padding(.bottom, 5)
                .font(.callout.weight(.bold))
            ForEach(viewModel.recipe.instructions) { instructionSet in
                ForEach(instructionSet.instructions) { instruction in
                    HStack {
                        Text("-").foregroundColor(ColorPalette.darkText)
                        Text(instruction.text).foregroundColor(ColorPalette.darkText)
                    }
                }
                HStack {
                    TextField("Description", text: $viewModel.instructionText)
                    Rectangle().fill(ColorPalette.highlight).frame(width: 1, height: 15, alignment: .center)
                    Button(action: viewModel.addInstruction) {
                        Text("add")
                            .foregroundColor(ColorPalette.highlight)
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(ColorPalette.highlight, lineWidth: 1)
                )
            }
        }
        .padding()
    }
}
