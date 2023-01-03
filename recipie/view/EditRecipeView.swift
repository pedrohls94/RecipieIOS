//
//  EditRecipeView.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import SwiftUI
import PhotosUI

struct EditRecipeView: View {
    @ObservedObject var viewModel: EditRecipeViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedItem: PhotosPickerItem? = nil

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
            horizontalBar
            ZStack(alignment: .bottomTrailing) {
                ImageHelper.getImageForRecipe(viewModel.recipe)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .center)
                    .clipped()
                
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Image("camera")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50, alignment: .bottomTrailing)
                            .clipped()
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
                    .frame(width: 50, height: 50, alignment: .bottomTrailing)
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            await viewModel.setRecipeImage(newItem)
                        }
                    }
            }
            horizontalBar
        }
    }
    
    var detailsView: some View {
        VStack(alignment: .leading) {
            Text("Recipe Name")
                .modifier(SectionTitle())
            
            TextField("Give a name to your recipe", text: $viewModel.recipeName)
                .modifier(BorderedHorizontalBox())
        }.padding()
    }
    
    var ingredientsView: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .modifier(SectionTitle())
            
            ForEach(viewModel.recipe.ingredients) { ingredient in
                Text("- \(String(format: "%g", ingredient.quantity)) \(ingredient.measurementUnit.toString()) \(ingredient.name)")
                    .foregroundColor(Color.text)
            }
            
            HStack {
                TextField("Name", text: $viewModel.ingredientName)
                verticalBar
                TextField("Quantity", text: $viewModel.ingredientQuantity)
                verticalBar
                Menu{
                    Picker("Measurement Unit", selection: $viewModel.ingredientMeasurementUnit) {
                        ForEach(MeasurementUnit.allCases, id: \.rawValue) { unit in
                            Text(unit.toString())
                        }
                    }.labelsHidden().pickerStyle(InlinePickerStyle())
                } label: {
                    Text(MeasurementUnit(rawValue: viewModel.ingredientMeasurementUnit)!.toString())
                        .foregroundColor(Color.highlight)
                }
                verticalBar
                Button(action: viewModel.addIngredient) {
                    Text("add")
                }
            }.modifier(BorderedHorizontalBox())
        }.padding()
    }
    
    var instructionsView: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .modifier(SectionTitle())
            
            ForEach(viewModel.recipe.instructions) { instructionSet in
                ForEach(instructionSet.instructions) { instruction in
                    Text("- \(instruction.text)")
                        .foregroundColor(Color.text)
                }
                HStack {
                    TextField("Description", text: $viewModel.instructionText)
                    verticalBar
                    Button(action: viewModel.addInstruction) {
                        Text("add")
                    }
                }.modifier(BorderedHorizontalBox())
            }
        }.padding()
    }
    
    var actionView: some View {
        VStack {
            Button(action: viewModel.save) {
                Text("Save")
            }
        }.padding()
    }
    
    var verticalBar: some View {
        Rectangle().fill(Color.highlight).frame(width: 1, height: 15, alignment: .center)
    }
    
    var horizontalBar: some View {
        Rectangle().fill(Color.highlight).frame(width: UIScreen.main.bounds.size.width, height: 2, alignment: .center)
    }
}
