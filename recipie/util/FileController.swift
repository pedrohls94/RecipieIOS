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
        
        let fileName = recipe.imageLocalPath ?? UUID().uuidString
        
        url.appendPathComponent(fileName)
        FileManager.default.createFile(atPath: url.path(), contents: image)
        return fileName
    }
    
    private static func getRecipeImageDirectoryPath() -> URL? {
        guard var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        url.appendPathComponent("recipeImages")
        
        var isDir:ObjCBool = true
        if !FileManager.default.fileExists(atPath: url.path(), isDirectory: &isDir) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        }
        
        return url
    }
    
    static func getImageData(from recipe: RecipeMO) -> Data? {
        guard
            let documentsUrl = getRecipeImageDirectoryPath(),
            let fileName = recipe.imageLocalPath
        else {
            return nil
        }
        
        let path = documentsUrl.appending(path: fileName).path()
        
        guard
            FileManager.default.fileExists(atPath: path)
        else {
            return nil
        }
        
        do {
            let url = URL(filePath: path)
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }
}
