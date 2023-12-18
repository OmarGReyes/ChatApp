//
//  User.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 18/10/23.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID = UUID()
    let name: String
    let imageURL: String
    let userId: String
    var lastInteraction: Date?
    var lastMessage: String?
    
    internal init(
        id: UUID = UUID(),
        name: String,
        imageURL: String,
        userId: String,
        lastInteraction: Date? = nil,
        lastMessage: String? = nil) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.userId = userId
        self.lastInteraction = lastInteraction
        self.lastMessage = lastMessage
    }
}

extension User {
    var lastInteractionHour: String {
        lastInteraction?.formatted(.dateTime.hour().minute()) ?? ""
    }

    init(data: [String: Any]) {
        self.userId = data["uid"] as? String ?? ""
        self.name = data["email"] as? String ?? ""
        self.imageURL = data["profileImageURL"] as? String ?? ""
    }
}
