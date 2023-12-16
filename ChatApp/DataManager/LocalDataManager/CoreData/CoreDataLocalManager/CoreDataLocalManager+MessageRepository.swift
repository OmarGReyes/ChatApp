//
//  CoreDataLocalManager+MessageRepository.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 25/11/23.
//

import Foundation

extension CoreDataLocalManager: MessageRepositoryProtocol {
    func fetchMessagesForUser(_ user: User) async throws -> [Message] {
        do {
           let messages = try await coreDataClient.getAll(
                entity: CDMessage.self,
                predicate: .MessagePredicates.findMessageByUserId(user.userId).predicate)
            .compactMap { $0.toDomain() }
            return messages
        } catch {
            throw error
        }
    }

    func addMessage(_ message: Message) async {
        let _ = try? await coreDataClient.add(entity: CDMessage.self, { CDMessage in
            CDMessage.message = message.message
            CDMessage.userId = message.userId
            CDMessage.received = message.received
            CDMessage.timestamp = message.timestamp
            CDMessage.id = message.id
        })
    }

    func updateUserLastInteraction(userId: String, timestamp: Date, message: String) async {
        let _ = try? await coreDataClient.update(entity: CDUser.self, predicate: .usersPredicates.findById(userId).predicate) { CDUser in
            CDUser.setValue(timestamp, forKey: "lastInteraction")
            CDUser.setValue(message, forKey: "lastMessage")
        }
    }
}
