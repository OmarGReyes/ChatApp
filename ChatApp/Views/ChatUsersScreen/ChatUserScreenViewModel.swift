//
//  ChatUserScreenViewModel.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 23/10/23.
//

import Foundation

//final class ChatUserScreenViewModel: ObservableObject {
//    @Published var messageManager: MessageManager
//    
//    init(messageManager: MessageManager) {
//        self.messageManager = messageManager
//    }
//    
//    func addMessage(message: Message) {
//        let userIndex = messageManager.users.firstIndex { user in
//            user.userId == message.userId
//        }
//        guard let userIndex else { return }
//        messageManager.addMessage(message: message, userIndex: userIndex)
//    }
//    
//    func getMessageByUserId(userId: String) -> [Message] {
//        let usersMessages = messageManager.messages.filter { message in
//            message.userId == userId
//        }
//        return usersMessages
//    }
//    
//    func getLastMessageByUserId(userId: String) -> Message {
//        messageManager.getLastMessageByUserId(userId: userId)
//    }
//    
//    func sortedUsers() -> [User] {
//        messageManager.users.sorted { $0.lastInteraction > $1.lastInteraction }
//    }
//}
