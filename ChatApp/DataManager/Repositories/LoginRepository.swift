//
//  LoginRepository.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/12/23.
//

import Foundation

protocol LoginRepositoryProtocol {
    func isUserLoggedIn() -> Bool
    func createUser(email: String, password: String, imageData: Data?) async throws
    func logInUser(email: String, password: String) async throws
}

struct LoginRepository: LoginRepositoryProtocol {
    let loginManager: LoginRepositoryProtocol
    func isUserLoggedIn() -> Bool {
        loginManager.isUserLoggedIn()
    }
    
    func createUser(email: String, password: String, imageData: Data?) async throws {
        try await loginManager.createUser(email: email, password: password, imageData: imageData)
    }
    
    func logInUser(email: String, password: String) async throws {
        try await loginManager.logInUser(email: email, password: password)
    }
}
