//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/10/23.
//

import SwiftUI
import Firebase

@main
struct ChatAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel(repository: FirebaseAuthManager(firebaseClient: FirebaseClient.shared)))
        }
    }
}
