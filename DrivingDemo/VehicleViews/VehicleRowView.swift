//
//  VehicleRowView.swift
//  DrivingDemo
//
//  Created by Vishal on 06/05/21.
//

import SwiftUI
import RealmSwift

struct VehicleRowView: View {
    @ObservedObject var vehicle: Vehicle
    @State var realm: Realm

//    let vehicle = Vehicle(vehicleType: "4 Wheeler", vehicleNo: "1234", name: "car")
    @State var gotoAddExpense: Bool = false
    @State var gotoExpenseList: Bool = false

    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            NavigationLink(
                destination: AddExpenseView(vehicleId: vehicle._id.stringValue, realm: realm),
                isActive: $gotoAddExpense,
                label: {
                    EmptyView()
                })
                .buttonStyle(PlainButtonStyle())
                .opacity(0)
            
            NavigationLink(
                destination: ExpenseListView(realm: realm, vehicleId: vehicle._id.stringValue),
                isActive: $gotoExpenseList,
                label: {
                    EmptyView()
                })
                .buttonStyle(PlainButtonStyle())
                .opacity(0)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(vehicle.name)
                        .font(.title3)
                }
                HStack {
                    Text(vehicle.vehicleNo)
                    Spacer()
                    Text(vehicle.vehicleType)
                }
            }
            .background(Color.white)
            .onTapGesture {
                print("cell tapped")
                gotoExpenseList = true
            }
            
            Button(action: {
                print("button tapped")
                gotoAddExpense = true
            }, label: {
                Text("Add Expense")
                    .foregroundColor(.blue)
            })
            .buttonStyle(PlainButtonStyle())
        }
        
    }
}

//struct VehicleRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        VehicleRowView()
//    }
//}
