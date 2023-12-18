//
//  ChatUserScreenViewModel.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 23/10/23.
//

import CoreData
import Foundation

enum ChatUsersScreenState {
    case loading
    case loaded
}

final class ChatUsersScreenViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var state:  ChatUsersScreenState = .loading
    private let usersRepository: UsersRepositoryProtocol
    
    init(usersRepository: UsersRepositoryProtocol) {
        self.usersRepository = usersRepository
    }
    
    func logOut() {
        try? FirebaseClient.shared.signOut()
    }
    
    func isAnyChatAvailable() -> Bool {
        guard !users.isEmpty else { return false }

        let userWithInteraction = users.first { user in
            user.lastInteraction != nil
        }

        return userWithInteraction != nil
    }

    func fetchUsers() async {
        let fetchedUsers = await usersRepository.fetchUsers()
        await MainActor.run(body: {
            users = fetchedUsers
            state = .loaded
        })
    }
    
    func addNewUser(userName: String) async {
        let userId = UUID().uuidString
        let newUser = User(name: userName, imageURL: "", userId: userId)
        await usersRepository.createUser(user: newUser)
        Task {
            await self.fetchUsers()
        }
    }
    
    func deleteUser(user: User) {
        Task {
            await usersRepository.deleteUser(user: user)
            await self.fetchUsers()
        }
    }

    func sortedUsers() -> [User] {
        users.filter { user in
            user.lastInteraction != nil
        }.sorted { $0.lastInteraction! > $1.lastInteraction! }
    }
    
    func sortedUsersAlphabetically() -> [User] {
        users.sorted { $0.name < $1.name }
    }
    
    func createChatScreenViewModel(user: User) -> ChatScreenViewModel {
        let repository = MessageRepository(localDataManager: CoreDataLocalManager(coreDataClient: CoreDataClient(PersistenceController.shared.viewContext)))
        return ChatScreenViewModel(user: user, repository: repository)
    }
}
