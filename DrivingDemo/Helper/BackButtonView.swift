//
//  BackButtonView.swift
//  DrivingDemo
//
//  Created by Vishal on 06/05/21.
//

import SwiftUI

struct BackButtonView: View {
    var action: () -> Void
    var body: some View {
        HStack {
            Button(action: action, label: {
                Text("Back")
            })
            Spacer()
        }
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView(action: {})
    }
}
