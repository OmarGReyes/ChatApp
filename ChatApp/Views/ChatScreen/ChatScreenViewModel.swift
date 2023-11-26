//
//  ChatScreenViewModel.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 2/11/23.
//

import Foundation

final class ChatScreenViewModel: ObservableObject {
    private var repository: MessageRepositoryProtocol
    @Published var messages: [Message] = []
    @Published var user: User
    
    init(user: User, repository: MessageRepositoryProtocol) {
        self.user = user
        self.repository = repository
    }
    
    func fetchMessages() async {
        if let messages = try? await repository.fetchMessagesForUser(user) {
            await MainActor.run {
                self.messages = messages
            }
        }
    }
    
    func addMessage(message: Message) async {
        await repository.addMessage(message)
        let _ = await (fetchMessages(), updateUserLastInteraction(timestamp: message.timestamp, message: message.message))
    }

    private func updateUserLastInteraction(timestamp: Date, message: String) async {
        await repository.updateUserLastInteraction(
            userId: user.userId,
            timestamp: timestamp,
            message: message)
    }
}
