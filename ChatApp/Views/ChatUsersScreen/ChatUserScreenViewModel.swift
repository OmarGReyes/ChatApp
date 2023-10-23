//
//  ChatUserScreenViewModel.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 23/10/23.
//

import Foundation

final class ChatUserScreenViewModel: ObservableObject {
    @Published var messages: [Message]
    private let messageManager: MessageManager
    
    init(messageManager: MessageManager) {
        self.messageManager = messageManager
        self.messages = messageManager.messages
    }
    
    func addMessage(message: Message) {
        messageManager.addMessage(message: message)
    }
    
    func getMessagesByUserId(userId: String) -> [Message] {
        let usersMessages = messageManager.messages.filter { message in
            message.userId == userId
        }
        return usersMessages
    }
    
    func getLastMessageByUserId(userId: String) -> Message {
        messageManager.getLastMessageByUserId(userId: userId)
    }
    
    func sortedUsers() -> [User] {
        // Should this function just be triggered when viewWill appear ?
        messageManager.users.sorted { $0.lastInteraction > $1.lastInteraction }
    }
}
