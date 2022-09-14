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
            imageView
            detailsView
            ingredientsView
            instructionsView
            actionView
        }
        .background(Color.background)
        .navigationTitle("Edit Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .padding([.leading, .trailing], 50)
        .onReceive(viewModel.$shouldDismiss) { shouldDismiss in
            if shouldDismiss {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    var imageView: some View {
        VStack(spacing: 0) {
            Rectangle().fill(Color.highlight).frame(width: UIScreen.main.bounds.size.width, height: 2, alignment: .center)
            viewModel.recipe.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .center)
                .clipped()
            Rectangle().fill(Color.highlight).frame(width: UIScreen.main.bounds.size.width, height: 2, alignment: .center)
        }
    }
    
    var detailsView: some View {
        VStack(alignment: .leading) {
            Text("Recipe Name")
                .foregroundColor(Color.text)
                .font(.callout.weight(.bold))
            TextField("Give a name to your recipe", text: $viewModel.recipeName)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.highlight, lineWidth: 1)
                )
        }
        .padding()
    }
    
    var ingredientsView: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .foregroundColor(Color.text)
                .padding(.bottom, 5)
                .font(.callout.weight(.bold))
            ForEach(viewModel.recipe.ingredients) { ingredient in
                HStack {
                    Text("- \(String(format: "%g", ingredient.quantity)) \(ingredient.measurementUnit.toString())").foregroundColor(Color.text)
                    Text(ingredient.name).foregroundColor(Color.text)
                }
            }
            HStack {
                TextField("Name", text: $viewModel.ingredientName)
                Rectangle().fill(Color.highlight).frame(width: 1, height: 15, alignment: .center)
                TextField("Quantity", text: $viewModel.ingredientQuantity)
                Rectangle().fill(Color.highlight).frame(width: 1, height: 15, alignment: .center)
                Menu{
                    Picker("Measurement Unit", selection: $viewModel.ingredientMeasurementUnit) {
                        ForEach(MeasurementUnit.allCases, id: \.rawValue) { unit in
                            Text(unit.toString())
                        }
                    }.labelsHidden().pickerStyle(InlinePickerStyle())
                } label: {
                    Text(MeasurementUnit(rawValue: viewModel.ingredientMeasurementUnit)!.toString()).foregroundColor(Color.highlight)
                }
                Rectangle().fill(Color.highlight).frame(width: 1, height: 15, alignment: .center)
                Button(action: viewModel.addIngredient) {
                    Text("add")
                        .foregroundColor(Color.highlight)
                }
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.highlight, lineWidth: 1)
            )
        }
        .padding()
    }
    
    var instructionsView: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .foregroundColor(Color.text)
                .padding(.bottom, 5)
                .font(.callout.weight(.bold))
            ForEach(viewModel.recipe.instructions) { instructionSet in
                ForEach(instructionSet.instructions) { instruction in
                    HStack {
                        Text("-").foregroundColor(Color.text)
                        Text(instruction.text).foregroundColor(Color.text)
                    }
                }
                HStack {
                    TextField("Description", text: $viewModel.instructionText)
                    Rectangle().fill(Color.highlight).frame(width: 1, height: 15, alignment: .center)
                    Button(action: viewModel.addInstruction) {
                        Text("add")
                            .foregroundColor(Color.highlight)
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.highlight, lineWidth: 1)
                )
            }
        }
        .padding()
    }
    
    var actionView: some View {
        VStack {
            Button(action: viewModel.save) {
                Text("Save").foregroundColor(Color.highlight)
            }
        }.padding()
    }
}
