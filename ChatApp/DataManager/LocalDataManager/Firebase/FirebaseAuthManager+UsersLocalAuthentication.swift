//
//  FirebaseAuthManager+UsersLocalAuthentication.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 18/12/23.
//

extension FirebaseAuthManager: UsersLocalAuthenticationProtocol {
    func fetchCurrentUserInfo() async throws -> User {
        let userData = try await firebaseClient.getCurrentUserInfo()
        return User(data: userData)
    }
}
