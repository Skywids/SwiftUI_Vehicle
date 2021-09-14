//
//  AddVehicleView.swift
//  DrivingDemo
//
//  Created by Vishal on 06/05/21.
//

import SwiftUI
import RealmSwift

struct AddVehicleView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var realm: Realm
    
    @State var vType: VehicleType = .wheeler2
    @State var name: String = ""
    @State var vehicleNo: String = ""
    
    var body: some View {
        VStack {
            BackButtonView(action: goBack)
            Spacer()
            fillDetailView
            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationBarHidden(true)
    }
}

fileprivate extension AddVehicleView {
    var fillDetailView: some View {
        VStack(spacing: 10) {
            TextField("Vehicle Name", text: $name)
                .setSpace()
            
            TextField("Vehicle Number", text: $vehicleNo)
                .setSpace()
            
            HStack {
                Picker("vehicle type", selection: $vType) {
                    ForEach(VehicleType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                Spacer()
                Text(vType.rawValue)
            }
            .setSpace()
            
            Button(action: addVehicle, label: {
                Text("Add Vehicle")
            })
            .setSpace()
        }
    }
    
    func goBack() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func addVehicle() {
        let vehicle = Vehicle(vehicleType: vType.rawValue, vehicleNo: vehicleNo, name: name)
        
        try! realm.write {
            realm.add(vehicle)
            goBack()
        }
    }
}

//struct AddVehicleView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddVehicleView()
//    }
//}
