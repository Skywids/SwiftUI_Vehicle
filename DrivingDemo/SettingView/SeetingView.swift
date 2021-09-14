//
//  SeetingView.swift
//  DrivingDemo
//
//  Created by Vishal on 19/05/21.
//

import SwiftUI
import RealmSwift

struct SeetingView: View {
    @ObservedObject var app: RealmSwift.App
    @State var realm: Realm
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: exportData, label: {
                Text("Export")
            })
            Button(action: importData, label: {
                Text("Import")
            })
            Button(action: logout, label: {
                Text("Logout")
            })
        }
    }
}

fileprivate extension SeetingView {
    func importData() {
        
    }
    
    func exportData() {
        let directoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = URL(fileURLWithPath: "backup1", relativeTo: directoryUrl).appendingPathExtension("realm")
        
        
        guard let realmUrl = realm.configuration.fileURL else { return }
        
        realm.beginWrite()
        
        do {
//            let d = try Data(contentsOf: realmUrl)
//            try d.write(to: fileUrl)
            
            try realm.writeCopy(toFile: fileUrl)
            
            print("file saved: \(fileUrl.absoluteURL)")
        } catch {
            print(error)
        }
        realm.cancelWrite()
        
    }
    
    func logout() {
        app.currentUser?.logOut()
    }
}

//struct SeetingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SeetingView()
//    }
//}
