//
//  ExpenseRowView.swift
//  DrivingDemo
//
//  Created by Vishal on 06/05/21.
//

import SwiftUI

struct ExpenseRowView: View {
    @ObservedObject var expense: Expense
    
//    let expense = Expense(date: "date", price: "5000", location: "gujarat", type: .service, detail: "details", vehicleId: "ididid", billImage: Data(), serviceCenter: "service center", servicePerson: "service person")
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(expense.type == .other ? expense.detail : expense.type.rawValue).font(.title3)
            HStack {
                Text("Amount: \(expense.price)")
                Spacer()
                Text("Date: \(expense.date)")
            }
            if expense.type == .service {
                HStack {
                    Text("Center: \(expense.serviceCenter)")
                    Spacer()
                    Text("Person: \(expense.servicePerson)")
                }
            }
            Text("Location: \(expense.location)")
            if let imageData = expense.billImage, let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(6)
            }
        }
    }
}

//struct ExpenseRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExpenseRowView()
//    }
//}
