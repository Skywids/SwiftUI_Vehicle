//
//  AddExpenseView.swift
//  DrivingDemo
//
//  Created by Vishal on 06/05/21.
//

import SwiftUI
import RealmSwift

struct AddExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var expenseType: ExpenseType = .fuel
    @State var detail: String = ""
    @State var selectedDate: Date = Date()
    @State var amount: String = ""
    @State var location: String = ""
    @State var vehicleId: String
    @State var serviceCenter: String = ""
    @State var servicePerson: String = ""
    @State var selectedImage: UIImage?
    @State var showAction: Bool = false
    
    @State fileprivate var activeSheet: ActiveSheet?
    
    @State var realm: Realm
    
    var body: some View {
        VStack {
            BackButtonView(action: goBack)
            Spacer()
            fillDetailView
            Spacer()
        }
        .padding(.horizontal, 20)
        .animation(.default, value: expenseType)
        .navigationBarHidden(true)
        .sheet(item: $activeSheet, content: { (item) in
            switch item {
            case .locationPicker:
                SearchLocationView(selectedPlace: $location, isPresented: .constant(activeSheet == nil ? false : true))
            case .imagePicker:
                ImagePicker(sourceType: .photoLibrary, uiImage: $selectedImage)
//                ImagePickerView(image: $selectedImage)
            }
        })
        .actionSheet(isPresented: $showAction) {
            sheet
        }
    }
}

fileprivate extension AddExpenseView {
    var fillDetailView: some View {
        VStack(spacing: 10) {
            HStack {
                Picker("Expense type", selection: $expenseType) {
                    ForEach(ExpenseType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                Spacer()
                Text(expenseType.rawValue)
            }
            .setSpace()
            
            if expenseType == .other {
                TextField("Detail", text: $detail)
                    .setSpace()
            }
            
            if expenseType == .service {
                TextField("Service Center", text: $serviceCenter)
                    .setSpace()
                TextField("Service Person", text: $servicePerson)
                    .setSpace()
            }
            
            TextField("Amount", text: $amount)
                .keyboardType(.numberPad)
                .setSpace()
            
            TextField("Location", text: $location)
                .setSpace()
                .onTapGesture {
//                    isLocationViewPresent.toggle()
                    activeSheet = .locationPicker
                }
            
            DatePicker("Fill Date", selection: $selectedDate, displayedComponents: .date)
                .frame(height: 40)
                .padding(.leading, 10)
                .addBorder(Color.gray, width: 2, cornerRadius: 10)
            
            imageToShow
                .frame(width: 100, height: 100)
                .background(Color.gray)
                .cornerRadius(6)
                .onTapGesture {
                    self.showAction = true
                }
            
            Button(action: addExpense, label: {
                Text("Add Expense")
            })
            .setSpace()
        }
    }
    
    var imageToShow: some View {
        if let image = selectedImage {
            return Image(uiImage: image).resizable()
        } else {
            return Image(systemName: "camera.on.rectangle")
        }
    }
    
    var sheet: ActionSheet {
        ActionSheet(
            title: Text("Action"),
            message: Text("Quotemark"),
            buttons: [
                .default(Text("Select from library"), action: {
                    self.showAction = false
                    activeSheet = .imagePicker
                }),
                .default(Text("Capture"), action: {
                    self.showAction = false
                    activeSheet = .imagePicker
                }),
                .cancel(Text("Close"), action: {
                    self.showAction = false
                }),
                .destructive(Text("Remove"), action: {
                    self.showAction = false
                    self.selectedImage = nil
                })
            ])
        
    }
    
    enum ActiveSheet: Identifiable {
        case locationPicker, imagePicker
        
        var id: Int {
            hashValue
        }
    }

    
    func goBack() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func addExpense() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        let expense = Expense(date: formatter.string(from: selectedDate),
                              price: amount,
                              location: location,
                              type: expenseType,
                              detail: detail,
                              vehicleId: vehicleId,
                              billImage: selectedImage?.pngData(),
                              serviceCenter: serviceCenter,
                              servicePerson: servicePerson)
        
        try! realm.write {
            realm.add(expense)
            goBack()
        }
        
    }
}

//struct AddExpenseView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddExpenseView(vehicleId: "")
//    }
//}
