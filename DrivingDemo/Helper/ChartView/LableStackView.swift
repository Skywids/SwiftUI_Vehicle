//
//  LableStackView.swift
//  DrivingDemo
//
//  Created by Vishal on 07/05/21.
//

import SwiftUI

struct LableStackView: View {
    @Binding var labels: [String]
    let spacing: CGFloat
    
    var body: some View {
        HStack(alignment: .center, spacing: spacing) {
            ForEach(labels, id: \.self) { label in
                Text(label)
                    .font(.system(size: 9))
//                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, spacing)
    }
}

//struct LableStackView_Previews: PreviewProvider {
//    static var previews: some View {
//        LableStackView()
//    }
//}
