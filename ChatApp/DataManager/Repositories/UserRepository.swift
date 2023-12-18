//
//  UserRepository.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 18/12/23.
//

import Foundation
// TODO: Add the remote when needed
protocol UsersRepositoryProtocol {
    func fetchCurrentUserInfo() async throws -> User
    func fetchUsers() async -> [User]
    func createUser(user: User) async
    func deleteUser(user: User) async
}

struct UsersRepository: UsersRepositoryProtocol {
    let usersLocalDataManager: UsersRepositoryProtocol

    func fetchCurrentUserInfo() async throws -> User {
        try await usersLocalDataManager.fetchCurrentUserInfo()
    }

    func fetchUsers() async -> [User] {
        await usersLocalDataManager.fetchUsers()
    }

    func createUser(user: User) async {
        await usersLocalDataManager.createUser(user: user)
    }

    func deleteUser(user: User) async {
        await usersLocalDataManager.deleteUser(user: user)
    }
}
