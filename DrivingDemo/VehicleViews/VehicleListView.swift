//
//  VehicleListView.swift
//  DrivingDemo
//
//  Created by Vishal on 06/05/21.
//

import Foundation
import SwiftUI
import RealmSwift

struct VehicleListView: View {
    @State var realm: Realm
    @State var vehicles: [Vehicle]?
    
    @State var gotoAddExpense: Bool = false

    init(realm: Realm) {
        _realm = State(initialValue: realm)
        
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().allowsSelection = false
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView {
            VStack {
                titleView
                List {
                    ForEach(vehicles ?? [], id: \.self) { vehicle in
                        VehicleRowView(vehicle: vehicle, realm: realm)
                            .listRowBackground(Color.clear)
//                        VehicleRowView()
                        
                    }
                }
                .listStyle(PlainListStyle())
            }
            .padding(.horizontal, 20)
            .onAppear {
                getVehicles()
            }
            .navigationBarHidden(true)
        }
    }
    
    
}

fileprivate extension VehicleListView {
    var titleView: some View {
        HStack {
            Spacer()
            Text("Vehicle Data")
                .font(.title)
            Spacer()
            NavigationLink("Add", destination: AddVehicleView(realm: realm))
        }
    }
    
    func getVehicles() {
        let data = realm.objects(Vehicle.self)
        self.vehicles = Array(data)
    }
}

//struct VehicleListView_Preview: PreviewProvider {
//    static var previews: some View {
//        AddVehicleView()
//    }
//}

