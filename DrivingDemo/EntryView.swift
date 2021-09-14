//
//  EntryView.swift
//  DrivingDemo
//
//  Created by Vishal on 04/05/21.
//

import SwiftUI
import RealmSwift

struct EntryView: View {
    @ObservedObject var app: RealmSwift.App
    @State var realm: Realm?
    
    var body: some View {
        nextView
    }
    
    var nextView: AnyView {
        guard let user = app.currentUser else {
            return LoginView(app: app).eraseToAnyView()
        }
        
        
        
        guard let realm = realm else {
            return AnyView(ProgressView()
                            .onReceive(Realm.asyncOpen(configuration: user.configuration(partitionValue: user.id)).assertNoFailure()) { realm in
//                                if realm.objects(FillUpData.self).count == 0 {
//                                    try! realm.write {
//                                        realm.add(FillUpData())
//                                    }
//                                }
                                self.realm = realm
                            })
            
           

        }
        
        return DashboardView(app: app, realm: realm).eraseToAnyView()
    }
    
    
}

//struct EntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryView()
//    }
//}
