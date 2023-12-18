//
//  CoreDataLocalManager.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 22/11/23.
//

protocol UsersLocalAuthenticationProtocol {
    func fetchCurrentUserInfo() async throws -> User
}

protocol UsersLocalStorageProtocol {
    func fetchUsers() async -> [User]
    func createUser(user: User) async
    func deleteUser(user: User) async
}

struct UsersLocalDataManager {
    let localStorage: UsersLocalStorageProtocol
    let localAuthentication: UsersLocalAuthenticationProtocol
    
    init(localStorage: UsersLocalStorageProtocol,
         localAuthentication: UsersLocalAuthenticationProtocol) {
        self.localStorage = localStorage
        self.localAuthentication = localAuthentication
    }
}

extension UsersLocalDataManager: UsersRepositoryProtocol {
    func fetchCurrentUserInfo() async throws -> User {
        try await localAuthentication.fetchCurrentUserInfo()
    }
    
    func fetchUsers() async -> [User] {
        await localStorage.fetchUsers()
    }
    
    func createUser(user: User) async {
        await localStorage.createUser(user: user)
    }
    
    func deleteUser(user: User) async {
        await localStorage.deleteUser(user: user)
    }
}
