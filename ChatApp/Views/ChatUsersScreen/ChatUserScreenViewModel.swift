//
//  ChatUserScreenViewModel.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 23/10/23.
//

import Foundation

protocol ChatUserScreenViewModelProtocol: ObservableObject {
    func addMessage(message: Message)
    func getMessagesByUserId(userId: String) -> [Message]
    func getLastMessageByUserId(userId: String) -> Message?
    func sortedUsers() -> [User]
}


final class ChatUserScreenViewModel: ChatUserScreenViewModelProtocol, ObservableObject {
    @Published var messages: [Message]
    @Published var users: [User]
    private let messageManager: MessageManager
    
    init(messageManager: MessageManager) {
        self.messageManager = messageManager
        self.messages = messageManager.messages
        self.users = messageManager.users
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
    
    func getLastMessageByUserId(userId: String) -> Message? {
        messageManager.getLastMessageByUserId(userId: userId)
    }
    
    func sortedUsers() -> [User] {
        // Should this function just be triggered when viewWill appear ?
        messageManager.users.filter { user in
            user.lastInteraction != nil
        }.sorted { $0.lastInteraction! > $1.lastInteraction! }
    }
    
    func sortedUsersAlphabetically() -> [User] {
        users.sorted { $0.name < $1.name }
    }
}
