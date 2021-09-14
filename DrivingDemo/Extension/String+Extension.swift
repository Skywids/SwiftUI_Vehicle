//
//  String+Extension.swift
//  DrivingDemo
//
//  Created by Vishal on 07/05/21.
//

import Foundation

extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let date = formatter.date(from: self)
        
        return date ?? Date()
    }
}
