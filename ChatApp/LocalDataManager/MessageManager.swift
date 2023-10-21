//
//  MessageManager.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 21/10/23.
//

import Foundation

final class MessageManager: ObservableObject {
    @Published var messages = Message.mockMessages
    
    func addMessage(message: Message) {
        messages.append(message)
    }
    
    func getMessageByUserId(userId: String) -> [Message] {
        let usersMessages = messages.filter { message in
            message.userId == userId
        }
        return usersMessages
    }
    
    func getLastMessageByUserId(userId: String) -> Message {
        let message = getMessageByUserId(userId: userId).last ?? Message(message: "", received: false, timestamp: Date(), userId: "")
        return message
    }
    
    func sortedMessage() -> [Message] {
        return messages.sorted { $0.timestamp > $1.timestamp }
    }
}
