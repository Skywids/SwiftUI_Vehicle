//
//  BarPath.swift
//  DrivingDemo
//
//  Created by Vishal on 07/05/21.
//

import Foundation
import SwiftUI

struct BarPath: Shape {
  let data: Double
  let max: Double
  let min: Double
  
  func path(in rect: CGRect) -> Path {
    guard min != max else {
      return Path()
    }
    
    let height = CGFloat((data - min) / (max - min)) * rect.height
    let bar = CGRect(x: rect.minX, y: rect.maxY - (rect.minY + height), width: rect.width, height: height)
    
    return RoundedRectangle(cornerRadius: 5).path(in: bar)
  }
}
