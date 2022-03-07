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
      NavigationView {
        List {
          HStack(alignment: .center) {
            TextField("", text: $viewModel.name)
          }
        }
      }
    }
}
