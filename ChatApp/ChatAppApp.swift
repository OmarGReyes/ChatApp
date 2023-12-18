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
    let loginManager: LoginRepositoryProtocol
    init() {
        FirebaseApp.configure()
        self.loginManager = FirebaseAuthManager(firebaseClient: FirebaseClient.shared)
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel(
                repository: LoginRepository(loginManager: loginManager)
            ))
        }
    }
}
