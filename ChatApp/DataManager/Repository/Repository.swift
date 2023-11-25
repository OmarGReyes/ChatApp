//
//  Repository.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 21/11/23.
//

import Foundation
import Combine

protocol UsersRepositoryProtocol {
    func fetchUsers() async -> [User]
    func createUser(user: User) async
    func deleteUser(user: User) async
}

struct UsersRepository: UsersRepositoryProtocol {
    var usersLocalDataManager: UsersRepositoryProtocol
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


