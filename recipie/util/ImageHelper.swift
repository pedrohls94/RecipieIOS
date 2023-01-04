//
//  ImageHelper.swift
//  recipie
//
//  Created by Pedro Lenzi on 18/11/22.
//

import Foundation
import SwiftUI

class ImageHelper {
    static func createRandomImageForRecipe() -> UIImage {
        let background = UIImage(named: "pie-background")!.withTintColor(randomColor())
        let crust = UIImage(named: "pie-crust")!.withTintColor(randomColor())
        let filling = UIImage(named: "pie-filling")!.withTintColor(randomColor())
        let cover = UIImage(named: "pie-cover")!.withTintColor(randomColor())
        let toppingMiddle = UIImage(named: "pie-topping-middle")!.withTintColor(randomColor())
        let toppingOutline = UIImage(named: "pie-topping-outline")!.withTintColor(randomColor())
        
        let size = CGSize(width: 700, height: 500)
        UIGraphicsBeginImageContext(size)

        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        background.draw(in: areaSize)
        crust.draw(in: areaSize, blendMode: .normal, alpha: 1)
        filling.draw(in: areaSize, blendMode: .normal, alpha: 1)
        cover.draw(in: areaSize, blendMode: .normal, alpha: 1)
        toppingMiddle.draw(in: areaSize, blendMode: .normal, alpha: 1)
        toppingOutline.draw(in: areaSize, blendMode: .normal, alpha: 1)
        
        let pieImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return pieImage
    }
    
    static func randomColor() -> UIColor {
        return UIColor(
           red:   CGFloat(arc4random()) / CGFloat(UInt32.max),
           green: CGFloat(arc4random()) / CGFloat(UInt32.max),
           blue:  CGFloat(arc4random()) / CGFloat(UInt32.max),
           alpha: 1.0
        )
    }
}
