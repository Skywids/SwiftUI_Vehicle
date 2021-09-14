//
//  SearchLocationView.swift
//  DrivingDemo
//
//  Created by Vishal on 04/05/21.
//

import SwiftUI

struct SearchLocationView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var locationService = LocationService()
    @Binding var selectedPlace: String
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
                .frame(height: 20)
            ZStack(alignment: .trailing) {
                TextField("Search Location", text: $locationService.queryFragment)
                if locationService.status == .isSearching {
                    Image(systemName: "clock")
                        .foregroundColor(Color.gray)
                }
            }
            .setSpace()
            List {
                statusView
                ForEach(locationService.searchResults, id: \.self) { completionResult in
                    VStack(alignment: .leading) {
                        Text(completionResult.title)
                        Text(completionResult.subtitle)
                    }
                    .onTapGesture {
                        selectedPlace = completionResult.title
//                        isPresented = false
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .padding(.horizontal, 30)
    }
    
    
    @ViewBuilder var statusView: some View {
        switch locationService.status {
        case .noResults:
            Text("No result")
        case .error(let error):
            Text("Error: \(error)")
        default:
            EmptyView()
        }
    }
}

//struct SearchLocationView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchLocationView()
//    }
//}
