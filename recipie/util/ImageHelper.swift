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
        return recipe.image ?? Image("pie")
    }
}
