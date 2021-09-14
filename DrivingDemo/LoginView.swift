//
//  LoginView.swift
//  DrivingDemo
//
//  Created by Vishal on 04/05/21.
//

import SwiftUI
import RealmSwift

struct LoginView: View {
    @ObservedObject var app: RealmSwift.App
    @State var error: Error?
    @State var isLoggingIn = false
    
    var body: some View {
        VStack {
            if isLoggingIn {
                ProgressView()
            }
            
            if let error = error {
                Text("Error: \(error.localizedDescription)")
            }
            
            Button(action: login) {
                Text("Log in anonymously")
            }.disabled(isLoggingIn)
        }
    }
}

fileprivate extension LoginView {
    func login() {
        app.login(credentials: .anonymous) { (result) in
            if case let .failure(error) = result {
                print("Failed to log in: \(error.localizedDescription)")
                self.error = error
                return
            }
            
            print("logged in")
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
