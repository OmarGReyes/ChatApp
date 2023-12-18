//
//  Repository.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 21/11/23.
//

import Foundation

protocol MessageRepositoryProtocol {
    func fetchMessagesForUser(_ user: User) async throws -> [Message]
    func addMessage(_ message: Message) async
    func updateUserLastInteraction(userId: String, timestamp: Date, message: String) async
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


