//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/10/23.
//

import SwiftUI

@main
struct ChatAppApp: App {
    // Fix this to inject the dependencies from outside
    let usersRepository = UsersRepository(usersLocalDataManager: CoreDataLocalManager(coreDataClient: CoreDataClient(PersistenceController.shared.viewContext)))
    var body: some Scene {
        WindowGroup {
            // This could be an environmentObject
            ChatUsersScreen(viewModel: ChatUsersScreenViewModel(
                persistenceController: PersistenceController.shared,
                usersRepository: usersRepository)
            )
        }
    }
}
