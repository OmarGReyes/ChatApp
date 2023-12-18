//
//  FirebaseAuthManager.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/12/23.
//

import Foundation

final class FirebaseAuthManager {
    let firebaseClient: FirebaseClient
    
    init(firebaseClient: FirebaseClient) {
        self.firebaseClient = firebaseClient
    }
}

extension FirebaseAuthManager: LoginRepositoryProtocol {
    func createUser(email: String, password: String, imageData: Data?) async throws {
        try await firebaseClient.createUser(email: email, password: password, imageData: imageData)
    }
    
    func logInUser(email: String, password: String) async throws {
        try await firebaseClient.signInUser(email: email, password: password)
    }
    
    func isUserLoggedIn() -> Bool {
        firebaseClient.getCurrentUserId() != nil
    }
}
