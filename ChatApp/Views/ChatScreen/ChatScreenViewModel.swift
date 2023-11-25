//
//  ChatScreenViewModel.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 2/11/23.
//

import Foundation

final class ChatScreenViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.viewContext
    @Published var messages: [Message] = []
    @Published var user: User
    
    init(user: User) {
        self.user = user
        fetchMessages(user: user)
    }
    
    func fetchMessages(user: User) {
        let request = CDMessage.fetch()
        request.predicate = NSPredicate(format: "userId == %@", user.userId as CVarArg)
        do {
            messages = try viewContext.fetch(request).compactMap({ CDMessage in
                Message(CDMessage: CDMessage)
            })
        } catch {
            print("Decoding error")
        }
    }
    
    func addMessage(message: Message) {
        messages.append(message)
        let CDMessage = CDMessage(context: viewContext)
        CDMessage.id = message.id
        CDMessage.userId = message.userId
        CDMessage.received = false
        CDMessage.timestamp = message.timestamp
        CDMessage.message = message.message
        
        updateUserLastInteraction(timestamp: message.timestamp, message: message.message)
        save()
    }
    
    private func save() {
        do {
            try viewContext.save()
        } catch(let error) {
            print(error)
        }
    }
    
    private func updateUserLastInteraction(timestamp: Date, message: String) {
        let request = CDUser.fetch()
        request.predicate = NSPredicate(format: "id == %@", user.userId as CVarArg)
        do {
            let CDuser = try viewContext.fetch(request).first
            CDuser?.setValue(timestamp, forKey: "lastInteraction")
            CDuser?.setValue(message, forKey: "lastMessage")
            save()
        } catch {
            print("error")
        }
    }
}
