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

protocol MessageRepositoryProtocol {
    func fetchMessagesForUser(_ user: User) async throws -> [Message]
    func addMessage(_ message: Message) async
    func updateUserLastInteraction(userId: String, timestamp: Date, message: String) async
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

struct MessageRepository: MessageRepositoryProtocol {
    var localDataManager: MessageRepositoryProtocol
    
    func fetchMessagesForUser(_ user: User) async throws -> [Message] {
        if let messages = try? await localDataManager.fetchMessagesForUser(user) {
            return messages
        } else {
            return []
        }
    }
    
    func addMessage(_ message: Message) async {
        await localDataManager.addMessage(message)
    }

    func updateUserLastInteraction(userId: String, timestamp: Date, message: String) async {
        await localDataManager.updateUserLastInteraction(userId: userId, timestamp: timestamp, message: message)
    }
}


