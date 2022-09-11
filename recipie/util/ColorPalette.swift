//
//  ColorPalette.swift
//  recipie
//
//  Created by Pedro Lenzi on 12/09/22.
//

import SwiftUI

class ColorPalette {
    static var background: Color { return platinum }
    static var highlight: Color { return skobeloff }
    static var darkText: Color { return darkJungleGreen }
    
    private static var platinum = Color(hex: "DCE1DE")
    private static var darkJungleGreen = Color(hex: "1F2421")
    private static var skobeloff = Color(hex: "216869")
    private static var shinyShamrock = Color(hex: "49A078")
    private static var etonBlue = Color(hex: "9CC5A1")
}
