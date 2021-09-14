//
//  ContentView.swift
//  DrivingDemo
//
//  Created by Vishal on 30/04/21.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var vehicleNo: String = ""
    @State var vType: VehicleType = .wheeler2
    @State var fType: FuelType = .Petrol
    @State var selectedDate = Date()
    @State var selectedLocation: String = ""
    @State var fuelPrice: String = ""
    
    @State var isLocationViewPresent: Bool = false
    @State var realm: Realm
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
                    Text("Back")
                })
                Spacer()
            }
            Spacer()
            
            fillDetailsView
            
            Spacer()
            
        }
        .padding(.horizontal, 30)
        .navigationBarHidden(true)
        .sheet(isPresented: $isLocationViewPresent) {
            SearchLocationView(selectedPlace: $selectedLocation, isPresented: $isLocationViewPresent)
        }
    }
}

fileprivate extension ContentView {
    func addData() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
//        let data = Vehicle(vehicleType: vType.rawValue, vehicleNo: vehicleNo, location: selectedLocation, fuelType: fType.rawValue, fuelPrice: fuelPrice, filldate: formatter.string(from: selectedDate))
        
//        let expense = Expense(date: "123", price: "565", location: "gujarat", type: .fuel, vehicleId: "")
//        
//        try! realm.write {
//            realm.add(expense)
//            self.presentationMode.wrappedValue.dismiss()
//        }
        
    }
    
    var fillDetailsView: some View {
        VStack(spacing: 10) {
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
            
            TextField("Vehicle no.", text: $vehicleNo)
                .setSpace()
            
            TextField("Location", text: $selectedLocation)
                .textContentType(.location)
                .setSpace()
                .onTapGesture {
                    isLocationViewPresent.toggle()
                }
            
            HStack {
                Picker("Fuel type", selection: $fType) {
                    ForEach(FuelType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                Spacer()
                Text(fType.rawValue)
            }
            .setSpace()
            
            TextField("Fuel price", text: $fuelPrice)
                .keyboardType(.numberPad)
                .setSpace()
            
            DatePicker("Fill Date", selection: $selectedDate, displayedComponents: .date)
                .frame(height: 40)
                .padding(.leading, 10)
                .addBorder(Color.gray, width: 2, cornerRadius: 10)
            
            Button(action: addData, label: {
                Text("Add Data")
            })
            .setSpace()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
