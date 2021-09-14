//
//  DashboardView.swift
//  DrivingDemo
//
//  Created by Vishal on 10/05/21.
//

import SwiftUI
import RealmSwift

struct DashboardView: View {
    @ObservedObject var app: RealmSwift.App
    @State var realm: Realm
    var body: some View {
        TabView {
            VehicleListView(realm: realm)
                .tabItem {
                    Label("Vehicle", systemImage: "car.fill")
                }
            
            ChartView(realm: realm)
                .tabItem {
                    Label("Charts", systemImage: "chart.pie")
                }
            
            SeetingView(app: app, realm: realm)
                .tabItem {
                    Label("Seeting", systemImage: "gearshape")
                }
            
        }
    }
    
    var logout: some View {
        Button(action: {
            app.currentUser?.logOut()
        }, label: {
            Text("Logout")
        })
    }
}

//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView()
//    }
//}
