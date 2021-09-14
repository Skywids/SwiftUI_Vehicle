//
//  View+Extension.swift
//  DrivingDemo
//
//  Created by Vishal on 30/04/21.
//

import Foundation
import SwiftUI

extension View {
     public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
         let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
         return clipShape(roundedRect)
              .overlay(roundedRect.strokeBorder(content, lineWidth: width))
     }
    
    public func setSpace() -> some View {
        self
            .frame(height: 40)
            .padding(.horizontal, 10)
            .addBorder(Color.gray, width: 2, cornerRadius: 10)
    }
    
    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
 }
