//
//  FileManager.swift
//  recipie
//
//  Created by Pedro Lenzi on 16/11/22.
//

import Foundation

class FileController {
    static func saveImageData(_ image: Data, forRecipe recipe: RecipeMO) -> String? {
        guard var url = getRecipeImageDirectoryPath() else {
            return nil
        }
        
        url.appendPathComponent("\(recipe.objectID)")
        
        do {
            try image.write(to: url)
            return url.absoluteString
        } catch {
            return nil
        }
    }
    
    private static func getRecipeImageDirectoryPath() -> URL? {
        guard var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        url.appendPathComponent("recipeImages")
        return url
    }
    
    static func getImageData(from recipe: RecipeMO) -> Data? {
        guard
            let path = recipe.imageLocalPath,
            FileManager.default.fileExists(atPath: path),
            let url = URL(string: path)
        else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }
}
