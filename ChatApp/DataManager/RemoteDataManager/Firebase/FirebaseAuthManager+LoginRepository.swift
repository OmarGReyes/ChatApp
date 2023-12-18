//
//  FirebaseAuthManager+LoginRepository.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 18/12/23.
//
import Foundation

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
