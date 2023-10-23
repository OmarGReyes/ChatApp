//
//  MessageManager.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 21/10/23.
//

import Foundation

// This should be exclusively connect with database and remote manager
// Además debería ser un objeto compartido en toda la aplicación (? debido a que
// modificarlo en un lugar afecta otras pantallas
final class MessageManager: ObservableObject {
    @Published var messages = Message.mockMessages // Call from DB
    @Published var users = User.sampleUsers // Same here call from DB
    
    func addMessage(message: Message) {
        let userIndex = users.firstIndex { user in
            user.userId == message.userId
        }
        guard let userIndex else { return }
        messages.append(message)
        users[userIndex].lastInteraction = message.timestamp
    }
    
    func getMessageByUserId(userId: String) -> [Message] {
        let usersMessages = messages.filter { message in
            message.userId == userId
        }
        return usersMessages
    }
    
    func getLastMessageByUserId(userId: String) -> Message {
        let message = getMessageByUserId(userId: userId).last ??
        Message(message: "", received: false, timestamp: Date(), userId: "")
        return message
    }
    
    func sortedUsers() -> [User] {
        return users.sorted { $0.lastInteraction > $1.lastInteraction }
    }
}
