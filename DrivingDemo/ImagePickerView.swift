//
//  testView.swift
//  DrivingDemo
//
//  Created by Vishal on 10/05/21.
//

import SwiftUI

struct ImagePickerView: View {
    var body: some View {
        Menu("chart") {
            Button("Order Now", action: placeOrder)
                        Button("Adjust Order", action: adjustOrder)
                        Button("Cancel", action: cancelOrder)
        }
        
    }
    
    
    func placeOrder() { }
        func adjustOrder() { }
        func cancelOrder() { }
}

struct tImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView()
    }
}
