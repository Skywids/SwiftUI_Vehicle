//
//  DrivingDemoApp.swift
//  DrivingDemo
//
//  Created by Vishal on 30/04/21.
//

import SwiftUI
import Combine
import RealmSwift

let realmApp: RealmSwift.App = RealmSwift.App(id: "application-0-osaaz")

@main
struct DrivingDemoApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            EntryView(app: realmApp)
        }
    }
}
