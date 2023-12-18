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
