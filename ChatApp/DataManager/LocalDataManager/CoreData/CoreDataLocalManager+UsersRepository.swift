//
//  CoreDataLocalManager+UsersRepository.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 22/11/23.
//

import Foundation

extension CoreDataLocalManager: UsersRepositoryProtocol {
    
    func fetchUsers() async -> [User] {
        do {
            let users = try await coreDataClient.getAll(entity: CDUser.self)
            
            return users.compactMap { user in
                User(CDUser: user)
            }
        } catch {
            return []
        }
    }
    
    func createUser(user: User) async {
        let _ = try? await coreDataClient.add(entity: CDUser.self) { CDUser in
            CDUser.id = user.userId
            CDUser.name = user.name
            CDUser.imageURL = user.imageURL
            CDUser.lastInteraction = user.lastInteraction
            CDUser.lastMessage = user.lastMessage
        }
    }
    
    func deleteUser(user: User) async {
        try? await coreDataClient.delete(entity: CDUser.self, predicate: .usersPredicates.findById(user.userId).predicate)
    }
}
