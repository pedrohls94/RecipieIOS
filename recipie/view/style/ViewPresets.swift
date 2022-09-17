//
//  ViewPresets.swift
//  recipie
//
//  Created by Pedro Lenzi on 17/09/22.
//

import Foundation
import SwiftUI

struct BorderedHorizontalBox: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.highlight, lineWidth: 1)
            )
    }
}

struct SectionTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.text)
            .padding(.bottom, 4)
            .font(.callout.weight(.bold))
    }
}
