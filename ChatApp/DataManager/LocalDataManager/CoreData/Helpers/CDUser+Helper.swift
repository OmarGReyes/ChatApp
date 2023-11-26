//
//  CDUser+Helper.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 25/11/23.
//

extension CDUser {
    func toDomain() -> User {
        User(name: name ?? "",
             imageURL: imageURL ?? "",
             userId: id ?? "",
             lastInteraction: lastInteraction,
             lastMessage: lastMessage)
    }
}
