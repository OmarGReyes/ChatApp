//
//  ChatUserScreenViewModel.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 23/10/23.
//

import CoreData
import Foundation

protocol ChatUserScreenViewModelProtocol: ObservableObject {
    func sortedUsers() -> [User]
}


final class ChatUsersScreenViewModel: ChatUserScreenViewModelProtocol, ObservableObject {
    @Published var users: [User] = []
    private let viewContext: NSManagedObjectContext
    private let usersRepository: UsersRepositoryProtocol
    
    init(persistenceController: PersistenceController,
         usersRepository: UsersRepositoryProtocol) {
        self.viewContext = persistenceController.viewContext
        self.usersRepository = usersRepository
    }
    
    func isAnyChatAvailable() -> Bool {
        guard !users.isEmpty else { return false }

        let userWithInteraction = users.first { user in
            user.lastInteraction != nil
        }

        return userWithInteraction != nil
    }
    
    // Esto lo debo hacer en el dataManager es decir, pasar la solicitud y que allá resuelvan ósea la función sí pero
    // la ejecución del request al viewContext y todo eso no
    func fetchUsers() async {
        let fetchedUsers = await usersRepository.fetchUsers()
        await MainActor.run(body: {
            users = fetchedUsers
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
    
    private func save() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving")
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
        ChatScreenViewModel(user: user)
    }
}
