//
//  ImageHelper.swift
//  recipie
//
//  Created by Pedro Lenzi on 18/11/22.
//

import Foundation
import SwiftUI

class ImageHelper {
    static func getImageForRecipe(_ recipe: Recipe) -> Image {
        if let uiImage = recipe.image {
            return Image(uiImage: uiImage)
        } else {
            return Image("pie")
        }
    }
}
